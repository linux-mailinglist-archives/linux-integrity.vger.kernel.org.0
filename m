Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2876230CE7C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 23:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhBBWLm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 17:11:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:55091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233598AbhBBWLh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 17:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612303791;
        bh=mmmvmqJRMdapP4z8zmy673XOwyd87Kegs4AcHgFei9I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CwvB3tnR6Uac23IXxAkG+KHCSXZbMH1S3ROqfQnH/f9ePujyn2bBW8zpEG7SIzxSU
         c0H4PJj1EP1t9fpdSz1ve1Ra4chDctNUNg59BQCRQhL/1bslPY1dPhgVEeTvG4NDGx
         ZMZo41GqWIfrC5GvlY10pFAyCXvW8sOSP/ZAyxtU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1lUwOl3gWP-00Ssg4; Tue, 02
 Feb 2021 23:09:50 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v2 0/3] TPM fixes
Date:   Tue,  2 Feb 2021 23:09:00 +0100
Message-Id: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:qZ9x3GSZd9i3RzYpVYe93PCWTPrCz18Qvf6YxOCb/QI1nWymCRj
 eOETNajCP28iqRo5hhhiDfsc7deCHN1KPjmx31cAxdgfnYDyz17ogz3rqpszt0tvznSnlSP
 LgPCF3r09eeTsdk5J737jN6A9eRbq/Z+TaQMrVdWkiwWSOCto/u275XjkxPNtQANksjiS2e
 ILMpFfMHSzixT55MVNHlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pqm3vknyDkU=:CwxuwarfkDioQfbBWdIrfX
 H0FbQ1D+DY1WwICXODDKmIKTLh+dkohzjQBfoVyfybivQViTXlBKpQeIWxjyi7emA2AsjuuhP
 HZxYX2E9IdFHLiSNTwb7Mqf+Mmxr3ZNvRhl6sbf+3AuYnmKdVY0XCKdKSf4GxXkewMnhzr7It
 F+ZdS1GoR9dDDjIGO+swGPmOw0ZRsc2G+n9R2cIod6+fkfxev2o9rgi5MoGviWwfleY3A8GjO
 2oEH6GoowdGn5QswxS7uMMifVahZHh8aBIU0LvyrATXq81WNcnroYsF4s0kQn639yQf3BdUCY
 lDs7hzcsdZ/iN1TYQL52YaqBfcWznZLKMHBMFVsW+My0Cvd8Aig2Ngu81Dwm/cmrjOJEFupoG
 Kt+eimH5AOO+rUXaLEwcla6ktDW5c1Mh2SV2YZi3STyESkt/PMrUpYPXirORwro9hWwuou5+e
 PYCphXGchPxEydUkuYYGLTMXh8NYFSGxwk+DhEKWq6H9wryS7uPAiOn9pLLzCOEWiH2EfFuUk
 2sXu5MOaG0PP5F8G51uReOMedLlP8rKqEZJ6rpwAMAjfgSsz7CGDXJ3gyErnQi9zKc9UVSSq0
 PK7FbL9Yp508KEdGTZ0Gc3EuKqXKcMxf11GI7LHWlMmIG8Volw+LCCrXfHQNVM5IE1ZNbTuNf
 IANdutTLyDOwQuqPKlko81nEtvTgWjC2gQhz+P2ZrAPdc4P7IFukFH0UQHDCu7/Oj+U5NL1ur
 hEuEscrE8foG1MREE9WomiKPBZf7UTjeebBpBUa29VwjkNWWLGlKC6VccZ/6+8+C5Ab+E1/Hz
 17kjufjR18hOkp7+p1BhkdFEpJi1vyqeL+beuiXZ6QpEOBYJYmZXfCssqQ7AGGD3eEH9R69Q4
 muNR6laCNZOmM3Pp6k3w==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBzZXJpZXMgZml4ZXMgYSByZWZlcmVuY2UgY291bnQgaXNzdWUgYW5kIGEgcG9zc2libGUg
TlVMTCBwb2ludGVyIAphY2Nlc3MgaW4gdGhlIFRQTSBjb3JlIGNvZGUuCkl0IGFsc28gaW50cm9k
dWNlcyBhIG5ldyBmdW5jdGlvbiB0cG1fY2hpcF9mcmVlKCkgd2hpY2ggaXMgdXNlZCBhcyB0aGUK
Y291bnRlcnBhcnQgdG8gdHBtX2NoaXBfYWxsb2MoKS4gVGhlIGZ1bmN0aW9uIGlzIHN1cHBvc2Vk
IHRvIGhpZGUgdGhlCmludGVybmFscyBvZiBhIHByb3BlciB0cG1fY2hpcCBkZWFsbG9jYXRpb24u
CgpDaGFuZ2VzIGluIHYyOgotIGRyb3AgdGhlIHBhdGNoIHRoYXQgZXJyb25lb3VzbHkgY2xlYW5l
ZCB1cCBhZnRlciBmYWlsZWQgaW5zdGFsbGF0aW9uIG9mCiAgYW4gYWN0aW9uIGhhbmRsZXIgbmkg
dHBtbV9jaGlwX2FsbG9jKCkgKHBvaW50ZWQgb3V0IGJ5IEphcmtrbyBTYWtraW5lbikKLSBtYWtl
IHRoZSBjb21taXQgbWVzc2FnZSBmb3IgcGF0Y2ggMSBtb3JlIGRldGFpbGVkCi0gYWRkIGZpeGVz
IHRhZ3MgYW5kIGtlcm5lbCBsb2dzCgoKTGlubyBTYW5maWxpcHBvICgzKToKICB0cG06IGZpeCBy
ZWZlcmVuY2UgY291bnRpbmcgZm9yIHN0cnVjdCB0cG1fY2hpcAogIHRwbTogUHJvdmlkZSBhIGZ1
bmN0aW9uIHRwbV9jaGlwX2ZyZWUoKSB0byBmcmVlIHRwbSBjaGlwcwogIHRwbTogaW4gdHBtMl9k
ZWxfc3BhY2UgY2hlY2sgaWYgb3BzIHBvaW50ZXIgaXMgc3RpbGwgdmFsaWQKCiBkcml2ZXJzL2No
YXIvdHBtL3RwbS1jaGlwLmMgICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oICAgICAgICAgICAgfCAgMSArCiBkcml2ZXJz
L2NoYXIvdHBtL3RwbTItc3BhY2UuYyAgICAgfCAxNSArKysrKysrKysrLS0tLS0KIGRyaXZlcnMv
Y2hhci90cG0vdHBtX2Z0cG1fdGVlLmMgICB8ICA0ICsrLS0KIGRyaXZlcnMvY2hhci90cG0vdHBt
X3Z0cG1fcHJveHkuYyB8ICAyICstCiA1IGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQoKLS0gCjIuNy40Cgo=
