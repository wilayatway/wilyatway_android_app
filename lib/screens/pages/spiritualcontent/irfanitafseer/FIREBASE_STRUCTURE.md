# Irfani Tafseer Firebase Structure

## Overview
The Irfani Tafseer module now supports structured content with sections, paragraphs, and ayats with detailed explanations.

## How to Differentiate Content

### 1. **Sections with Titles**
- Each introduction can have multiple sections
- Each section has an optional `sectionTitle` (e.g., "Lataif ko Munawwar Kaise Karein?")
- Section titles appear in **bold gold** color (Color.fromARGB(255, 200, 140, 60))

### 2. **Paragraphs**
- Within each section, you have a list of paragraphs
- Each paragraph is displayed in a **white card container**
- Paragraphs are separated with spacing for clarity
- Text is justified with proper line-height (1.8) for readability

### 3. **Individual Ayats**
- Each ayat has its own collapsible card
- Shows ayat number (in circle), Arabic text, and transliteration
- Click to expand and see:
  - **Description**: Brief explanation of the ayat
  - **Complete Tafseer**: Detailed mystical/spiritual interpretation

## Firebase Collection Structure

```
firestore
  ├── irfani_tafseer/
  │   ├── surah_fatiha/
  │   │   ├── id: "surah_fatiha"
  │   │   ├── titleEn: "Surah Al-Fatiha - The Opening"
  │   │   ├── titleUr: "سورہ الفاتحہ - کھولنا"
  │   │   ├── introductionEn: [
  │   │   │   {
  │   │   │     "sectionTitle": "Introduction: The Meaning of The Opening",
  │   │   │     "paragraphs": [
  │   │   │       "Surah Fatiha ka matlab hai 'The Opening'...",
  │   │   │       "Yeh opening asal me realms ki opening hai..."
  │   │   │     ]
  │   │   │   },
  │   │   │   {
  │   │   │     "sectionTitle": "Lataif ko Munawwar Kaise Karein?",
  │   │   │     "paragraphs": [
  │   │   │       "Maghrib aur Tahajjud ke zikr se..."
  │   │   │     ]
  │   │   │   },
  │   │   │   {
  │   │   │     "sectionTitle": null,  // Optional - sections without title
  │   │   │     "paragraphs": [
  │   │   │       "Paragraph without section heading..."
  │   │   │     ]
  │   │   │   }
  │   │   ]
  │   │   ├── introductionUr: [
  │   │   │   {
  │   │   │     "sectionTitle": "تعارف: 'کھولنے' کا مطلب",
  │   │   │     "paragraphs": [
  │   │   │       "سورہ الفاتحہ کا مطلب 'کھولنا' ہے...",
  │   │   │       "یہ کھولنا درحقیقت عوالم کا کھولنا ہے..."
  │   │   │     ]
  │   │   │   }
  │   │   ]
  │   │   ├── ayats: [
  │   │   │   {
  │   │   │     "ayatNumber": 1,
  │   │   │     "ayatTextAr": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
  │   │   │     "transliterationEn": "Bismillaahir Rahmaanir Raheem",
  │   │   │     "transliterationUr": "بسم اللہ الرحمن الرحیم",
  │   │   │     "descriptionEn": "In the Name of Allah, the Most Merciful...",
  │   │   │     "descriptionUr": "اللہ کے نام سے، جو بہت رحم والا...",
  │   │   │     "tafseelEn": "Yahan Rahman aur Raheem ka zikr isliye...",
  │   │   │     "tafseelUr": "یہاں رحمان اور رحیم کا ذکر اس لیے..."
  │   │   │   },
  │   │   │   {
  │   │   │     "ayatNumber": 2,
  │   │   │     ...
  │   │   │   }
  │   │   ]
  │   │
  │   ├── another_topic/ (similar structure)
```

## Content Formatting Guide

### For Section Titles
- Should be **concise and bold** (e.g., "Ayat 1", "Introduction", "Lataif ko Munawwar Kaise Karein?")
- Automatically styled in gold color
- Optional - can be null for sections without titles

### For Paragraphs
- Each paragraph should be a **complete thought or explanation**
- Use natural language (Hindustani/Urdu for Urdu version, English for English version)
- Keep paragraphs to 2-4 sentences for readability
- Break long content into multiple paragraphs

### For Ayat Content
- **transliterationEn/Ur**: How the Quran verse is read/pronounced
- **descriptionEn/Ur**: Simple explanation of what the verse means
- **tafseelEn/Ur**: Deep, mystical interpretation (Irfani explanation)

## Visual Layout

```
┌─────────────────────────────────────┐
│  Language Toggle: English | اردو     │
├─────────────────────────────────────┤
│  Surah Al-Fatiha - The Opening      │
│                                       │
│  ┌─────────────────────────────────┐ │
│  │ Introduction: The Meaning...     │ │
│  │ (Section Title in Gold)          │ │
│  │                                   │ │
│  │ Surah Fatiha ka matlab hai...    │ │
│  │ (Paragraph in white card)        │ │
│  │                                   │ │
│  │ Yeh opening asal me realms...    │ │
│  │ (Another Paragraph)              │ │
│  └─────────────────────────────────┘ │
│                                       │
│  ┌─────────────────────────────────┐ │
│  │ Lataif ko Munawwar Kaise...     │ │
│  │ (Another Section Title)          │ │
│  │                                   │ │
│  │ Maghrib aur Tahajjud ke zikr...  │ │
│  │ (Paragraph)                      │ │
│  └─────────────────────────────────┘ │
│                                       │
│  Ayats                               │
│  ┌─────────────────────────────────┐ │
│  │  1  بِسْمِ اللَّهِ...           │ │
│  │  Bismillaahir Rahmaanir Raheem   │ │
│  │                           ▼      │ │
│  │ (Click to Expand)               │ │
│  │                                   │ │
│  │ ┌─────────────────────────────┐ │ │
│  │ │ Description                 │ │ │
│  │ │ In the Name of Allah...     │ │ │
│  │ └─────────────────────────────┘ │ │
│  │ ┌─────────────────────────────┐ │ │
│  │ │ Complete Tafseer            │ │ │
│  │ │ Yahan Rahman aur Raheem...  │ │ │
│  │ └─────────────────────────────┘ │ │
│  └─────────────────────────────────┘ │
└─────────────────────────────────────┘
```

## Implementation Notes

1. **ContentSection Model**: Handles sections with optional titles and multiple paragraphs
2. **AyatDetail Model**: Contains all information needed for a single Quranic verse
3. **Language Switching**: Toggle between English and Urdu at the top - all content updates dynamically
4. **Expandable Ayats**: Click each ayat to see description and complete tafseer
5. **Responsive Design**: Uses SliverList for smooth scrolling with multiple content types

## Adding New Content

1. Create a new document in `irfani_tafseer` collection
2. Use the structure shown above
3. For introduction sections, group related paragraphs under same section title
4. For ayats, ensure all 8 fields are filled (even if empty string, don't use null)
5. Toggle language to verify both English and Urdu content display correctly
