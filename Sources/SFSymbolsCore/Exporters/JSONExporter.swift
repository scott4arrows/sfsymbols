//
//  JSONExporter.swift
//  
//
//  Created by Scott McAlister on 1/29/20.
//

import Foundation

public struct JSONExporter: Exporter {
    public func exportGlyph(_ glyph: Glyph, in font: Font, to folder: URL) throws { fatalError() }


    public func exportGlyphs(in font: Font, using options: ExportOptions) throws {
        try FileManager.default.createDirectory(at: options.outputFolder, withIntermediateDirectories: true, attributes: nil)
        let contentsURL = options.outputFolder.appendingPathComponent("SFSymbols.json")
        var contentsJSON = "["

        for glyph in font.glyphs(matching: options.matchPattern) {
            contentsJSON += exportJSON(glyph, in: font, to: contentsURL)
        }

        contentsJSON += "]"
        try Data(contentsJSON.utf8).write(to: contentsURL)
    }

    func exportJSON(_ glyph: Glyph, in font: Font, to file: URL) -> String {
        let contents = """
        {
            "name" : "\(glyph.fullName)",
            "keywords" : \(glyph.keywords),
            "categories" : \(glyph.categories),
            "isFilled" : \(glyph.isFilled),
            "appleOnly" : \(glyph.appleOnly),
            "restrictionNote" : "\(glyph.restrictionNote ?? "")"
        },
        """
        return contents
    } //     "keywords" : ["\"plus, add, create, new, increase\""],


    public func data(for glyph: Glyph, in font: Font) -> Data { fatalError() }

}
