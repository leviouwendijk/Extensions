// import Foundation
// import Structures
// import plate

// extension WAMessageTemplate {
//     // public func replacements() -> [StringTemplateReplacement] {
//     //     let syntax = PlaceholderSyntax(prepending: "{", appending: "}", repeating: 1)

//     //     return [
//     //         StringTemplateReplacement(
//     //             placeholders: ["client", "name"],
//     //             replacement: "",
//     //             placeholderSyntax: syntax
//     //         ),
//     //         StringTemplateReplacement(
//     //             placeholders: ["dog"],
//     //             replacement: "",
//     //             placeholderSyntax: syntax
//     //         ),
//     //         StringTemplateReplacement(
//     //             placeholders: ["deliverable"],
//     //             replacement: "",
//     //             placeholderSyntax: syntax
//     //         ),
//     //         StringTemplateReplacement(
//     //             placeholders: ["detail"],
//     //             replacement: "",
//     //             placeholderSyntax: syntax
//     //         ),
//     //         StringTemplateReplacement(
//     //             placeholders: ["price"],
//     //             replacement: "",
//     //             placeholderSyntax: syntax
//     //         ),
//     //     ]
//     // }
    
//     // deprecated
//     public func replaced(client: String, dog: String) -> String {
//         let syntax = PlaceholderSyntax(prepending: "{", appending: "}", repeating: 1)

//         return self.message
//             .replaceClientDogTemplatePlaceholders(client: client, dog: dog, placeholderSyntax: syntax)
//     }
// }
