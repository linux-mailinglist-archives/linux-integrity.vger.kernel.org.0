Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C467D1389A3
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 04:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgAMDPE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jan 2020 22:15:04 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:47174 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbgAMDPD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jan 2020 22:15:03 -0500
IronPort-SDR: 8iplrnjvZfOIR4koA25CFqWhCjK6xSmkl+MpUxBbTZpFfTVx82NtNUDCzCwVKgq4vdTDJFVAEW
 vNVz751xoDSg==
IronPort-PHdr: =?us-ascii?q?9a23=3AGHngYRbeX8myOt/NHKvXcXP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsy/bnLW6fgltlLVR4KTs6sC17ON9fq+CCddvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8gSjIdtKqs8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDI/923Zl9B/g7heoBOhvhBy3YnUYJuNNPp5ZKPSZ88aSn?=
 =?us-ascii?q?RYUslPUSxNG5+xb5cTD+UbIelYr5fyp14Qohu4GQmgHf3gyjlRinHx2q061f?=
 =?us-ascii?q?ouEAHf0AM+GdIFrXDYodvpOKsOVOy4yrTDwzfeYPNMwTrz5ojGcgo/r/+PQL?=
 =?us-ascii?q?x/ftbex0Y0GgPZjFiftZDpMy+J2ugTtWWQ8upuVfioi24iswx/uCagxtsyhY?=
 =?us-ascii?q?nTm4kaylfE9SN2wI0oItC4UFB0YcK6H5tKuSCaMI12Qsw5TmFooyY10aEJtY?=
 =?us-ascii?q?SncygNzZQr3R7fa/+efoWO/xntV/6RLC9miH54er+znQu+/Ea8xuHmSMW530?=
 =?us-ascii?q?xGoyRFn9TKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWc18r+ums6+T9fLrmooOQOoBuhgHgNaQhh9awAeo/Mg?=
 =?us-ascii?q?gIQWeX4/qz1Kb78U34RrVFkOE2n7HHvJzHJ8kXvLO1DgFJ3oo59RqyAC2q3d?=
 =?us-ascii?q?oYkHUfKVJKYhOHj4znO1HUJ/D4CO+yg0yynzd32f/GJLPgApLLLnjMi7rhfa?=
 =?us-ascii?q?195FVAxwYp0d9f4JdUBqsBIPLwQkPxrsDXDgclMwyoxObqENF91oIYWWKSDa?=
 =?us-ascii?q?6VKaLSsVmU5u0xLOmMfo4VuCr9KvU++f7ugmE2mUUHcamqw5QXcna4EepiI0?=
 =?us-ascii?q?mDZnrsmNgBQi82uV86Ter3mBiDVyJeaGyzQ7MU+D42EsSlAJ3FS4Trh6aOjx?=
 =?us-ascii?q?22BplHWmcTMl2QHG2gSIKCVL9YcC+OL9V+lToLVbuhUIUq/R6rvQ7+jbFgK7?=
 =?us-ascii?q?yH1DcfsMfb2cR4/aXskhc9vWhsAtiQyX6KSW5cnngCTHk926U5oU8rmQTL6r?=
 =?us-ascii?q?Rxn/ENTI8b3PhOSApvbsaEwg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GUIwCo3xtemCMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4?=
 =?us-ascii?q?VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgks?=
 =?us-ascii?q?BATOcbwGNBA0NAoUdgkkECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgF?=
 =?us-ascii?q?sgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2?=
 =?us-ascii?q?jN1eBDA16cTMagiYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GUIwCo3xtemCMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbDQEBA?=
 =?us-ascii?q?QEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNCwYph?=
 =?us-ascii?q?UqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOcbwGNBA0NA?=
 =?us-ascii?q?oUdgkkECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsgkiCWQSNQhIhg?=
 =?us-ascii?q?QeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1eBDA16cTMag?=
 =?us-ascii?q?iYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,427,1571695200"; 
   d="scan'208";a="304478847"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 13 Jan 2020 04:15:01 +0100
Received: (qmail 24910 invoked from network); 12 Jan 2020 05:00:24 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-integrity@vger.kernel.org>; 12 Jan 2020 05:00:24 -0000
Date:   Sun, 12 Jan 2020 06:00:19 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-integrity@vger.kernel.org
Message-ID: <2060469.460950.1578805224018.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

