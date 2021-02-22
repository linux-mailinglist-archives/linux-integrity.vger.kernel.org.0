Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E76320ECC
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 02:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhBVA6p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 19:58:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:39479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhBVA6o (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 19:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613955421;
        bh=fyRcvh+HjjFzd3C0++xTHAmEN143pcsZ0myNZ1HAD2E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ECwyP4Z7bXkaMzl4eD+/Uiv+smz38NAmxoC3DHiIjpCZkUIH1k15yfoNQsfXShQwo
         B1RjnUo2uIFlLyA7n7pfvkjJUy2QVQyI97bmXfpA7PHYLRpsocDLUU+cd22huP01uW
         8in7lUcH5bdbdfQLMUKKMfIGQ/DE+YCqgCMI8lXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1lzXgP1BS0-0132dK; Mon, 22
 Feb 2021 01:57:01 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        jsnitsel@redhat.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, LinoSanfilippo@gmx.de
Subject: [PATCH 0/4] Fixes for TPM interrupt handling
Date:   Mon, 22 Feb 2021 01:56:30 +0100
Message-Id: <1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:0xTq3JSP264R+YK6ls2mW7wLhbyRJHmbH1z8/QlWuS01CvrQkVe
 mS54pPp5aja6PIdkUgEmS2Rs17A31k1UTBcgBRlKx1EuDfT28ev3MlIXCkkOOo8Ycv7+jQN
 bajappV4mwYyw510+t4KlKELgIjCfmu027PqhOUZOdNytdn+HLuECN0yoTb2S1M6mXmpaU3
 gTUA3WoOpYL2o9mgTQ+qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fGgMlXMHxQI=:9elguvHH6RE099z3cEtwFp
 O5VkSpwyzjvSUlhK3aZm2jPIj4xBcSAZc6L2Y86O+3qqlsvB4V81/hqSSkC4kil4o167dNudn
 Hp70SELgl0boXxNYVvZIzczkFU39ld0mauV207kxUJwlj6D9n3uFc5TgWHjE7fkYvhEdyj7g3
 gL65rw4Bn8s7D38By9ID6nDQ6VDaq/Q6hoH99FQgmXd+Y2QqyUzhdVtDE1B1UyAMXnJ/I+VoE
 +S1OQuzsDoIMBG3HT+JB1ecrUavkjLzqDcSTO9dHXGHIf2Gvz9wdkp1oFy0rHsLm5bBhV8BOU
 BnJbpR1jQLAtbTgXlpQtafptTwh75keMqy6cXaZ7PStAOCOjBcj/d2LZ5VHMN9vIXt/9HTW/w
 nK0FTpcGxwQqqdUPF7DdekzbNDw+WXdNp67+huOzIL6Wo/j9y8PMXmWpduBH1e5dL+uYLkhf5
 ykac7EO+5nBCwHVBAWdA3tqaALrE+QkDWeiy67a1KPP3a3L93rH7CXQF04EPeJtZpXhfPE9S9
 kyZ7kGVDeJqqPoKOwaUyh/pdfIFjw5owmwOzKCpywwCa49QYlqOEyw4CECNHofO+SGqnDQ+dq
 q+WOwJgj5+FaIbswP/I03pA43t9DaupTwExR4aRY5KCOrlDNkDCcgve8765ENwfIFziGIoUX3
 8j1TTpZWhcNU9/dt8rE/UX4s+KjYY4iEJ/6EJumaRDj2d7lbg9shoZHkIK/jqHky8dsgzfnV2
 5QaXrK8xwY+nOSlMegyggLEIxMQrP1akKy1MhOqTlpKazMH6mvY0sP3WEUM4n7hzMc/2t+bUa
 H70ZPhjS5AOZ4Gii5xJVi0hRytPtOg8X0LHN2IpYKfY26TasKIXkLJFSJMRT8WF5QYuN0hJng
 LJ0jZ/7O4jfssSGfrZwA==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBzZXJpZXMgZml4ZXMgaXNzdWVzIGFyb3VuZCB0aGUgVFBNIGRyaXZlciBpbnRlcnJ1cHQg
aGFuZGxpbmcuIFRoZXNlCmlzc3VlcyBwcmV2ZW50IFRQTSBjaGlwcyBsaWtlIHRoZSBTTEIgOTY3
MCB0byB3b3JrIG92ZXIgU1BJLiAKClBBVENIIDE6IFRoZSBTUEkgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIGZ1bmN0aW9ucyB0byByZWFkL3dyaXRlIHRvL2Zyb20KcmVnaXN0ZXJzIHVzZXMgbXV0ZXhl
cyBhbmQgdGh1cyByZXF1aXJlIGEgc2xlZXBhYmxlIGNvbnRleHQuIEZvciB0aGlzCnJlYXNvbiBy
ZXF1ZXN0IGEgdGhyZWFkZWQgaW50ZXJydXB0IGhhbmRsZXIuCgpQQVRDSCAyOiBTaW1wbGlmeSBs
b2NhbGl0eSBoYW5kbGluZyBieSB0YWtpbmcgdGhlIGRyaXZlciBsb2NhbGl0eSAoMCkgYXQKZHJp
dmVyIHN0YXJ0dXAgYW5kIHJlbGVhc2luZyBpdCBhdCBkcml2ZXIgc2h1dGRvd24uIFRoaXMgYWxz
byBmaXhlcyBhCndhcm5pbmcgYXQgZHJpdmVyIHN0YXJ0dXAgdGhhdCBpcyBjYXVzZWQgYnkgYSBy
ZWdpc3RlciBhY2Nlc3Mgd2l0aG91dCBwcmlvcgpsb2NhbGl0eSByZXF1ZXN0LgoKUEFUQ0ggMzog
Rml4IGFuZCBzaW1wbGlmeSB0aGUgdGVzdCBmb3Igd29ya2luZyBpbnRlcnJ1cHRzLgoKUEFUQ0gg
NDogT25seSBzZXQgdGhlIGludGVycnVwdHMgd2hpY2ggYXJlIHJlcG9ydGVkIGFzIGJlaW5nIGF2
YWlsYWJsZS4KCldpdGggdGhlc2UgcGF0Y2hlcyBhcHBsaWVkIHRoZSBTTEIgOTY3MCB3b3JrcyBh
cyBleHBlY3RlZDogaW50ZXJydXB0cyBhcmUKZGV0ZWN0ZWQgYW5kIHRoZSB0cmFuc21pdC9yZWNl
aXZlIG9wZXJhdGlvbnMgYXJlIGNvbnRyb2xsZWQgYnkgaW50ZXJydXB0CmhhbmRsaW5nLgoKVGhl
IHBhdGNoZXMgYXJlIGJhc2VkIG9uIExpbnV4IG1haW5saW5lIFY1LjExCgoKTGlubyBTYW5maWxp
cHBvICg0KToKICB0cG06IFVzZSBhIHRocmVhZGVkIGludGVycnVwdCBoYW5kbGVyCiAgdHBtOiBn
ZXQgbG9jYWxpdHkgYmVmb3JlIHdyaXRpbmcgdG8gVFBNIGNoaXAKICB0cG06IEZpeCB0ZXN0IGZv
ciBpbnRlcnJ1cHRzCiAgdHBtOiBPbmx5IGVuYWJsZSBzdXBwb3J0ZWQgaXJxcwoKIGRyaXZlcnMv
Y2hhci90cG0vdHBtLWNoaXAuYyAgICAgfCAgMTAgLS0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1f
dGlzX2NvcmUuYyB8IDEyNyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5oIHwgICAyICstCiBpbmNsdWRlL2xpbnV4
L3RwbS5oICAgICAgICAgICAgIHwgICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlv
bnMoKyksIDc5IGRlbGV0aW9ucygtKQoKLS0gCjIuNy40Cgo=
