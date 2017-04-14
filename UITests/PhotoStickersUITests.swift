//
//  PhotoStickersUITests.swift
//  PhotoStickersUITests
//
//  Created by Jochen Pfeiffer on 28/12/2016.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import XCTest

class PhotoStickersUITests: XCTestCase {

    fileprivate var app: XCUIApplication?

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app?.launchArguments += ["-RunningUITests", "true"]
        setupSnapshot(app!)
        app?.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testSnapshots() {
        guard let app = self.app else {
            fatalError()
        }

        let stickerCollectionNavigtionBar = app.navigationBars["StickerCollectionNavigtionBar"]
        XCTAssert(stickerCollectionNavigtionBar.exists)

        let addButtonItem = stickerCollectionNavigtionBar.buttons["AddButtonItem"]
        XCTAssert(addButtonItem.exists)

        snapshot("Sticker Collection")

        addButtonItem.tap()

        let imageSourceAlertButtonPhotoLibrary = app.sheets.buttons["ImageSourceAlertButtonPhotoLibrary"]
        XCTAssert(imageSourceAlertButtonPhotoLibrary.exists)

        let imageSourceAlertButtonCamera = app.sheets.buttons["ImageSourceAlertButtonCamera"]
        XCTAssert(imageSourceAlertButtonCamera.exists)

        if isIPad(app: app) {
            app.children(matching: .window).element(boundBy: 0).tap()
        } else {
            let imageSourceAlertButtonCancel = app.sheets.buttons["ImageSourceAlertButtonCancel"]
            XCTAssert(imageSourceAlertButtonCancel.exists)
            imageSourceAlertButtonCancel.tap()
        }

        snapshot("Edit Sticker Empty")

        let circleButton = app.buttons["CircleButton"]
        XCTAssert(circleButton.exists)

        let rectangleButton = app.buttons["RectangleButton"]
        XCTAssert(rectangleButton.exists)

        let multiStarButton = app.buttons["MultiStarButton"]
        XCTAssert(multiStarButton.exists)

        let starButton = app.buttons["StarButton"]
        XCTAssert(starButton.exists)

        let editStickerNavigationBar = app.navigationBars["EditStickerNavigationBar"]
        XCTAssert(editStickerNavigationBar.exists)

        let editStickerToolbar = app.toolbars["EditStickerToolbar"]
        XCTAssert(editStickerToolbar.exists)

        let saveButtonItem = editStickerNavigationBar.buttons["SaveButtonItem"]
        XCTAssert(saveButtonItem.exists)

        let cancelButtonItem = editStickerNavigationBar.buttons["CancelButtonItem"]
        XCTAssert(cancelButtonItem.exists)

        let deleteButtonItem = editStickerToolbar.buttons["DeleteButtonItem"]
        XCTAssert(deleteButtonItem.exists)

        let photoButtonItem = editStickerToolbar.buttons["PhotoButtonItem"]
        XCTAssert(photoButtonItem.exists)

        cancelButtonItem.tap()

        let collectionView = app.collectionViews["StickerCollectionView"]
        XCTAssert(collectionView.exists)

        let firstStickerCell = collectionView.cells.matching(identifier: "StickerCollectionCell").element(boundBy: 0)
        XCTAssert(firstStickerCell.exists)

        firstStickerCell.tap()

        rectangleButton.tap()

        snapshot("Edit Sticker")

        saveButtonItem.tap()
    }

    fileprivate func isIPad(app: XCUIApplication) -> Bool {
        return app.windows.element(boundBy: 0).horizontalSizeClass == .regular && app.windows.element(boundBy: 0).verticalSizeClass == .regular
    }
}
