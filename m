Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D9601DFF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJQX6X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiJQX6S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD047E03A;
        Mon, 17 Oct 2022 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051072;
        bh=BzRmHyDjx6k9QxSMFomIGBOCh5qkOm5olPta9ZMqnS8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j/khhM9e5wP+lpawLuxx74yOycNZXoKBT8E+6UYh2N4nvDr3jZCVR2NR0MfC9UUjW
         v1i1nNtrlQNm/nxRPJFFAw4ffa+MKvNCqbgebowRaQWfqu5L/Azcw3JpSRH5ZbdwJx
         gpFcC52q61PtXpoYj5CU0gxa04wxFgo66VzPL03c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1ovHNh1Lzd-00FhEt; Tue, 18
 Oct 2022 01:57:52 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 06/11] tpm, tpm_tis: Move interrupt mask checks into own function
Date:   Tue, 18 Oct 2022 01:57:27 +0200
Message-Id: <20221017235732.10145-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:WDob0q+nal8PS7PWDU+fKAFyHJK7IwCY8X4P/1Xsz/Pgvm8OM6r
 sl7h41ANDn+c6YsHCP7tPEqtOCh5M/LnOpygKNBlI/Vgg7DqrPRqmi42JeCocQncP3j+ZTs
 LNxp+JnMjWWWuavT/jQb2ErlHMtJhG7cbQ3X2lNDQxpMeRNULLAKqWoc0C8as7Qyps7ub1P
 B5QLqclCbJJZZx4EBYH6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gXPKTH2PjG4=:obtYWnaAhcTFSm6nRSj41U
 4L0ea1LbBk+IGzYTWSIkiQ2KAWTWOeL1Mg4ds1i9Z1uVPMHNgdzgzBphJWkXeCqUU7iWC6CDQ
 ncACL0qaYwYuaraYtDuaApr47WWSiJdw6SxVziYLWigKZOCTXejOunP6FoBwj9NqgDdws8wmH
 gFujY6APnrkbsOoSEaZW7sZs6f7JqyXlry7PWbgg4f4j3dPWPutfbDo23n9bRIb/PisVF1QGk
 79TfhGmOn9V6mUlzn9uo3DjyjlLtDS0+SBJeTQyl3slnzKT3wXjagtMcx0XQGE73vtVqSS8Jb
 C63XDNAaq2QNB0WaSLEFGRhvbEDs7om8GwQaZ3h27erb6uh8WAbYnEgZxj2m1w87HzijCcFZA
 3oIhA8WY2LTB5RBGlmN9G02XpbfNNqjQnGa63Tc1U+CaGU3gMV6us2SVTBiUi4tLfImdfSQ9Y
 P7cTugXDM/3gfk37zo+7pzWP/iF0zQfKFMJJGFuZga7dC55gE31NewPs7sE06kmaPWCFHRTYj
 yO9/clrLQmxO3v10pFo5FtRrWwWCA+RS7VjcWwbv9FvQW63CC3Q4H0nwBJ2lxLN8HVx9NPmuS
 oqBlvMHMu43DmGRxXLKZAmJ8ytqolv8g3Dj5EQBO2kF2v/7W5JjvOtqs43bNxz/N6KlGk6UpQ
 LQGDKzTXGPcf3mbUrk5OR0MKd4ikeRuaWiq6/7SFBr2N8FMnT/qTYYVh5b88c8DRJRrq6B7Px
 OwAtlpfqG/60/osl2IOjFjqNQjyVhsBfbeGettlGdtVYVLjISD010NyS+EQXSXU7uBsqS/c5L
 kcovYy2NmQYuoL9liIXSDQfRLi0ha0acvrIE9aDEmug1z57BdDUzrTIq02XMufFMaaNy9s8/7
 GXrCmcql/dTXbSBZ0WjDP4x1RD4UZntujYro2w+y+3bXAvrhfO1bWOR6FW3Ttgzd7AVnwqk36
 /SB25OQG91xW/YynhPrMcKxqxQTU06ovB8RXVP9wBSoL+WO3PvAfN2eQFRUaKtqOo75IpZM0i
 El4YU9ghJashgo5A3YXUKR160KTVe85dohopTAB5wpC+dFNr+twCi/escG1ACDlsnsg7BrBh/
 JHOLp7c4qZf/RusBoMu+dS1V6Qp0QDQ+8E/2k7Wloo0MPomWisYVxk5hJDUoqGqyq2MwUWF9R
 B4Ap4Bg9L3JI5TtMXJPDhlpPAj5p7SB4tpP3V5+taTwZe/Jt/f64x0xHbtgFjYtWT5w1m7sme
 ylSUAmTieYCCDulxjF7kt+7RU+rPM4FXnPBtRBknkBm+aG8LXGBM0/O9WlYS3aFMZ71cMkQaI
 4HvckO10vJO4eYXF4Y3igLUysSkQSWHDjRgs/Kcp+jWDd4Weh0USfseA8LsYyOeAAu8swICPO
 httAa7pv8NvpbQbGMPJMVFGmeEECHUz4IGsm24e9yvhp/at05WhTkiiIZMCf1KD67PYO9kS6H
 veBKYlaiDEhhtXPT2eJUoQaY0jXrawG6xnwNVnhvXF7Z9XStCw8O+qI/uJXvcoUJKUxMHxfvb
 yUihLO8RDuJh2HJLB6DDV+6IS7jPIPErp/s9rfgnBjpVU
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkNsZWFuIHVw
IHdhaXRfZm9yX3RwbV9zdGF0KCkgYnkgbW92aW5nIG11bHRpcGxlIHNpbWlsYXIgaW50ZXJydXB0
IG1hc2sKY2hlY2tzIGludG8gYW4gb3duIGZ1bmN0aW9uLgoKU2lnbmVkLW9mZi1ieTogTGlubyBT
YW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KU3VnZ2VzdGVkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVu
IDxqYXJra29Aa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5j
IHwgMjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIv
dHBtL3RwbV90aXNfY29yZS5jIGIvZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYwppbmRl
eCBkMDdkZWJjMzE4MmMuLjE4MWMyOTFiMGJiOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3Rw
bS90cG1fdGlzX2NvcmUuYworKysgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCkBA
IC00NCw2ICs0NCwyMCBAQCBzdGF0aWMgYm9vbCB3YWl0X2Zvcl90cG1fc3RhdF9jb25kKHN0cnVj
dCB0cG1fY2hpcCAqY2hpcCwgdTggbWFzaywKIAlyZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB1
OCB0cG1fdGlzX2ZpbHRlcl9zdHNfbWFzayh1OCBpbnRfbWFzaywgdTggc3RzX21hc2spCit7CisJ
aWYgKCEoaW50X21hc2sgJiBUUE1fSU5URl9TVFNfVkFMSURfSU5UKSkKKwkJc3RzX21hc2sgJj0g
flRQTV9TVFNfVkFMSUQ7CisKKwlpZiAoIShpbnRfbWFzayAmIFRQTV9JTlRGX0RBVEFfQVZBSUxf
SU5UKSkKKwkJc3RzX21hc2sgJj0gflRQTV9TVFNfREFUQV9BVkFJTDsKKworCWlmICghKGludF9t
YXNrICYgVFBNX0lOVEZfQ01EX1JFQURZX0lOVCkpCisJCXN0c19tYXNrICY9IH5UUE1fU1RTX0NP
TU1BTkRfUkVBRFk7CisKKwlyZXR1cm4gc3RzX21hc2s7Cit9CisKIHN0YXRpYyBpbnQgd2FpdF9m
b3JfdHBtX3N0YXQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCQl1bnNpZ25lZCBs
b25nIHRpbWVvdXQsIHdhaXRfcXVldWVfaGVhZF90ICpxdWV1ZSwKIAkJYm9vbCBjaGVja19jYW5j
ZWwpCkBAIC01Myw3ICs2Nyw3IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3RydWN0
IHRwbV9jaGlwICpjaGlwLCB1OCBtYXNrLAogCWxvbmcgcmM7CiAJdTggc3RhdHVzOwogCWJvb2wg
Y2FuY2VsZWQgPSBmYWxzZTsKLQl1OCBzdHNfbWFzayA9IDA7CisJdTggc3RzX21hc2s7CiAJaW50
IHJldCA9IDA7CiAKIAkvKiBjaGVjayBjdXJyZW50IHN0YXR1cyAqLwpAQCAtNjEsMTcgKzc1LDEw
IEBAIHN0YXRpYyBpbnQgd2FpdF9mb3JfdHBtX3N0YXQoc3RydWN0IHRwbV9jaGlwICpjaGlwLCB1
OCBtYXNrLAogCWlmICgoc3RhdHVzICYgbWFzaykgPT0gbWFzaykKIAkJcmV0dXJuIDA7CiAKKwlz
dHNfbWFzayA9IG1hc2sgJiAoVFBNX1NUU19WQUxJRCB8IFRQTV9TVFNfREFUQV9BVkFJTCB8CisJ
CQkgICBUUE1fU1RTX0NPTU1BTkRfUkVBRFkpOwogCS8qIGNoZWNrIHdoYXQgc3RhdHVzIGNoYW5n
ZXMgY2FuIGJlIGhhbmRsZWQgYnkgaXJxcyAqLwotCWlmIChwcml2LT5pbnRfbWFzayAmIFRQTV9J
TlRGX1NUU19WQUxJRF9JTlQpCi0JCXN0c19tYXNrIHw9IFRQTV9TVFNfVkFMSUQ7Ci0KLQlpZiAo
cHJpdi0+aW50X21hc2sgJiBUUE1fSU5URl9EQVRBX0FWQUlMX0lOVCkKLQkJc3RzX21hc2sgfD0g
VFBNX1NUU19EQVRBX0FWQUlMOwotCi0JaWYgKHByaXYtPmludF9tYXNrICYgVFBNX0lOVEZfQ01E
X1JFQURZX0lOVCkKLQkJc3RzX21hc2sgfD0gVFBNX1NUU19DT01NQU5EX1JFQURZOwotCi0Jc3Rz
X21hc2sgJj0gbWFzazsKKwlzdHNfbWFzayA9IHRwbV90aXNfZmlsdGVyX3N0c19tYXNrKHByaXYt
PmludF9tYXNrLCBzdHNfbWFzayk7CiAKIAlzdG9wID0gamlmZmllcyArIHRpbWVvdXQ7CiAJLyog
cHJvY2VzcyBzdGF0dXMgY2hhbmdlcyB3aXRoIGlycSBzdXBwb3J0ICovCi0tIAoyLjM2LjEKCg==
