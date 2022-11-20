Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858563144B
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Nov 2022 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKTNci (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Nov 2022 08:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKTNc3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Nov 2022 08:32:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A779D9;
        Sun, 20 Nov 2022 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668951127; bh=qYlv/2skNZrIAGuyoSI3M0nAcicGS7Q3OukmLXnsYCU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bINaJezFcxVr1hZkuhXGGG/2P5YvXFPExjykSf9Aq9BWFSnyc/JG0CKtSXqG0ernX
         2mzba7mnHeqr+CI+MxQlACgpMiOgLUiQKiDPcvzYVKo5LmUJC8E1ZYysC3HIzOevwz
         yHGHpCVB/RiUHpBUL3D21AMXSsSQtRSkMpIzM/O+Hr3/9hr7/aquYtCWt27BLLdZ+2
         XswO/1Nl25iqGmwI0O8jXAKJbua+gi02OGgYQRPc/9gonIcF7kEduS5t9XyQ+R7yA7
         vLGfUtwqmo3pGUsebmfyl1gcrcQrLj1ezfEAurNIpdtXXURybv8BCbpjWtUODnIuDA
         Am3yXkp2FwWeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1pO4dU02Ex-00k9Um; Sun, 20
 Nov 2022 14:32:07 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v10 07/14] tpm, tpm_tis: Move interrupt mask checks into own function
Date:   Sun, 20 Nov 2022 14:31:27 +0100
Message-Id: <20221120133134.28926-8-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:pWAON8thYn0lythSLMLr5a6vn8X+rSQV7RGJf4FePhBemJDVbHJ
 Hewfyiy1zoHiO0PppPaKhgFHzzdJOC87VLsVk9STi0amA2vvqZY0KydBmpGEFPiv5DDM9LX
 Fd7tTrVkkVkDcP62zmMBR1J4jzv90OhubpvkyUnQ5jEaBXN1GJNQe3zG54pm5ksBZS0J8pr
 YsENuCqXjdQ1cejij1sGA==
UI-OutboundReport: notjunk:1;M01:P0:8z07yEUH/Mc=;A3pki4bQWNkoOeu7W1hASW4PWAp
 r+JGTVzFFTA4hfnr/BNz6rB5gwW0j/zWH+SzD6VS7gA7246S4p6yh29mk6jemwuqSHqctC0rR
 Z3IDdr7u1ZPcUv6m+zxOJmHl46pKj1g85IPP4AKnJCR6TwqlqBFj2nHp+8tXqJBPmlaNd8CGR
 IJ6QdjMCaSNDiIWs3FTcP5+CCF8m1i4NYT+pig63RE0I7EWaRZ49auUxHlaJK0KAkWJvYkD/5
 dxBRW0zL7wqz+Wp1JeH0v47gAnDrnW9N9ktJcnv17vnFcI3Jp81xgGKERe+mN0DBnC5yOv/yv
 MZ61v/wpHVl51hwWoSPTVYzhQAxtZ2dWYqZAxMcOy4dlUUCSE9a5aQFwJ/i/owt4QaLSkidCb
 RROsFrLFFo7AH3jbLn7G198Dk7Q0hgkUx18P0THrCqu0ajd1ZrMoATmjgSDccFpW5rwGrM5DW
 KUscoqZi/ZwhGMGXVbIKRvQcaB7jNbN6+AZ0m0YjBcSsnbHuwc4I9OMNQyWpiLAyPoI5y5TbB
 Yq26m37IruH9lOLydrMmDpT5n/grc5/4SfbBNNI01EW6IFB2pPmXoNv+qM8giVg9BBXlMuxph
 tQUxZrCoCqS6TFed3LcGgCmuMQQjXYpZaxMm9UWm8ZI6QVQ934DBMIt+fN5RBPCMOOmZV0iF7
 +EIBMgVBExnCUiwdRXEdB1svC9cwz0WJeuc1pgZsNNqTCkmx2Lq0XBHxWbaqoijPOC4CL47t7
 ZA2576RoFBqrmub9VI1ZzCnLEJVJvrdy+DJOY7ys5sHNom6HeXQhB18WttHi3z78pBOnIf8iv
 Rz/+Sq6Mo+lCQZGF50TzGpZknmc3oVKTIHFGLXkEgkbTTo1So8cNZWtAHKAo596cqoiFmJ68V
 /GzG3GLcBXw4wvPlyFsVaKMuGgjFPTTHcmK9l3GmyCpdLVHMfmLXx6UAvGkZn+pq7IqlcYgjR
 6kVPQg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
eCBmYmFkOTJiMTg3ODguLjVmZjRjYTVmYjkzNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL3Rw
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
