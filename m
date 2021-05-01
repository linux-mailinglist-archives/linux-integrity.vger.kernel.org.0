Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45F437077C
	for <lists+linux-integrity@lfdr.de>; Sat,  1 May 2021 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEAOC3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 10:02:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:50487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhEAOC2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 10:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619877685;
        bh=RgBW5Llz3Gd05UPmRrb/vbkD7pYHh6Mi+0IqtBPln2I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XdKvzKFbe3iEtKke6KioJXeTfxgB2SPHwT5Si4Wwmenh2pv/+fk201mHIjpIwlKCh
         CpNDzs++OuAruXQWmfWiRK1imqAtCxK/qwX6A+0pyUzIJFsIahBkdU974UPSYaEVvc
         b4/si9yddez5SwFZMJHRKSslOio9LVTZ5qlFGCZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1lHzyr0OUe-00uMYz; Sat, 01
 May 2021 16:01:25 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
Subject: [PATCH v3 0/4] Fixes for TPM interrupt handling
Date:   Sat,  1 May 2021 15:57:23 +0200
Message-Id: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:aiaCLqpOKyoGAAuVi0cfk9zRy3LK1+nvq+0Xw8lzQKVUVwohYzV
 3jgYWbp9klzCLC6lx1PRgDV7i19Or4k3NZmeDkMyBJXWmSTrvPqDkPf0ziCt49HFxGNkydO
 e+mRJOETdKVVQDEFf7j4gzDXWNzGxeOt3XN8tNBoO7zLY9CJwovtwGMmgPVf4G6dG5UjCbk
 y573jfjNtG1JLjXA9IHGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gAzax5rgC1s=:dnfqU71FG/BrKDmGP5C8Kr
 Cjq1Mzkm5nPdRthUYok3cMeMjJ64dIgQy3qV6VXJpHgb5N3fbvRQm5ohHus5q4G1DAzKemTFA
 csKyb5zvj7+c+xfO/xLa10/9nlZSWMACb6Ouu05SbEA64tNseq7o2wx2qltbfiodoCeiA90Gu
 OF2BaLcgUFJB0bf/KcLSI9O7xLSUWdMC/1H2Llgqy7qyq14+flk087YXxUwNDCZmfj+OLNoea
 gwLhmKll0a7ii2g+Xnzof2dvAEe0EU6xADD3H3x9SydZRpdSLlVtBxgKYccK1r5fzO/+FXyXk
 kHFrcqHIE5dimuLleXZrtnnmkQzRGJgJIFZk5fCZBP3beCnpbFINUI3DW7wluQRp06TeNBrHb
 +21jzxRWQ0gS2XQ3ga1IO1t5rjS++rRZ919uQGbAlI6Rid7HQRw5GnvRvkqri+rufw3OKjj4n
 MsPiRRRs+kAmtnAM4tT9Zo6iIAwHjEB11tMaKeRWQQMjm4440D+40ZPDBa/jal3xZLAdz04I8
 Ztr12dO8kOyzweAVMeI+YkqVwxa+t9AMydrgVbiMAjvvwwHVA/lj2MRpRmlUkDOmYQA8b26Jr
 YbXLkq9QMc1sZkpN1fulxj/ia5hmWqDPAr5eS073YoMvJ1vaggfaxJCZFACnXeQelOJrMuEaF
 qs2XqfYW0ITmlRahjyul8fVq7Ep1osTISb4NTZTMl5nNFup0QepKdKD/4ZxrwK8G88BTlk2HL
 sMwMZFYtnCw2s6Tmcwqz3RoIbgs9ArwC2+22us7c7G58Pj02MYA53i/Yd2sW7UQcKLaClZxBI
 +2fQ/1IBXLqQD19/ehVsDK/DBFpIYh/lO3sqqORwxBQvtpqeRRgu3+kPLAqhESJTGGBjFPKTT
 Ln5KJHp6GWFEkvEnrksa28iHSoGsUukjITD/ZDbeGc2xuyNIkWLJb/UTznfFKhiRSRMGvExnk
 lXqiw6o/kiXwiBoGe0B7K+rl/wAt4aW2CdWpvK7vFeunyHDAlxjkIJ8kt0MTmrka4MM6ITo1F
 NfVK8CyZIXZJuTecD2RsS1aaOO/nnnEDON6cUtwngJMZoq9SVrQWFgyBbtw8FiCcMqfzcAU4l
 yeirbBuskgl0+LqvYIrGsL2xJCyxaaPqlmFsSG0PiPOhHaUB+07pFeVxTy7ivw/HX5mw3iDP1
 q1YbbWiAgSleS/Uck8pjgxLA65EFvTIaixjjv9gJwkQ/r1kQekZ6Eri4tisvEN6ZBvCcKq4kT
 Q+H1ZQATwOly8ZCCk
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBzZXJpZXMgZW5hYmxlcyBpbnRlcnJ1cHRzIGZvciBUUE0uIEZvciB0aGlzIHNvbWUgb2Jz
dGFjbGVzIGhhZCB0byBiZQpyZW1vdmVkIGZpcnN0LCBsaWtlIHRoZSBpbnRlcnJ1cHQgaGFuZGxl
ciBydW5uaW5nIGluIGludGVycnVwdCBjb250ZXh0IGFuZAp0aHVzIG5vdCBhbGxvd2luZyB0byBh
Y2Nlc3MgcmVnaXN0ZXJzIG92ZXIgU1BJLiBBbHNvIHRoZSBsb2NhbGl0eSBoYW5kbGluZwpoYXMg
YmVlbiBzaW1wbGlmaWVkIHRvIG1ha2UgYSBjb21wbGljYXRlZCBzeW5jaHJvbml6YXRpb24gYmV0
d2VlbiB0aHJlYWRzCmFuZCBpcnEgaGFuZGxlciB1bm5lY2Vzc2FyeS4gQXMgYSBzaWRlIGVmZmVj
dCBvZiB0aGlzIHNpbXBsaWZpY2F0aW9uIGEgYnVnCmlzIGZpeGVkIGluIHdoaWNoIGEgVE1QIGNv
bW1hbmQgaXMgaXNzdWVkIHdpdGhvdXQgYSBjbGFpbWVkIGxvY2FsaXR5IGluCmNhc2Ugb2YgVFBN
IDIuCkFub3RoZXIgZml4IGNvbmNlcm5zIHRoZSBpbnRlcnJ1cHQgdGVzdCB3aGljaCBjdXJyZW50
bHkgaXMgYnJva2VuLgpGaW5hbGx5IHRoZSByZXN1bHRzIG9mIHRoZSBjYXBhYmlsaXR5IHF1ZXJ5
IGF0IHN0YXJ0dXAgaXMgdXNlZCB0byBvbmx5IHNldAp0aGUgaW50ZXJydXB0cyB3aGljaCBhcmUg
YWN0dWFsbHkgc3VwcG9ydGVkIGJ5IHRoZSBoYXJkd2FyZS4KClRoZXNlIHBhdGNoZXMgYXJlIGJh
c2VkIG9uIGNvbW1pdCA5ZjY3NjcyYTgxN2UgKCJNZXJnZSB0YWcgJ2V4dDRfZm9yX2xpbnVzJwpv
ZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdHl0c28vZXh0
NCIpIGFuZCB0ZXN0ZWQgb24Kb24gYSBTTEIgOTY3MCB3aGljaCBpcyBjb25uZWN0ZWQgdmlhIFNQ
SS4KCk9mIGNvdXJzZSBhbnkgZnVydGhlciB0ZXN0aW5nIGlzIGhpZ2hseSBhcHByZWNpYXRlZC4K
ClBBVENIIDE6IFRoZSBTUEkgaW1wbGVtZW50YXRpb24gb2YgdGhlIGZ1bmN0aW9ucyB0byByZWFk
L3dyaXRlIHRvL2Zyb20KcmVnaXN0ZXJzIHVzZXMgbXV0ZXhlcyBhbmQgdGh1cyByZXF1aXJlIGEg
c2xlZXBhYmxlIGNvbnRleHQuIEZvciB0aGlzCnJlYXNvbiByZXF1ZXN0IGEgdGhyZWFkZWQgaW50
ZXJydXB0IGhhbmRsZXIuCgpQQVRDSCAyOiBTaW1wbGlmeSBsb2NhbGl0eSBoYW5kbGluZyBieSB0
YWtpbmcgdGhlIGRyaXZlciBsb2NhbGl0eSAoMCkgYXQKZHJpdmVyIHN0YXJ0dXAgYW5kIHJlbGVh
c2luZyBpdCBhdCBkcml2ZXIgc2h1dGRvd24uIFRoaXMgYWxzbyBmaXhlcyBhIGJ1ZwppbiBjYXNl
IG9mIFRNUCAyLgoKUEFUQ0ggMzogRml4IGFuZCBzaW1wbGlmeSB0aGUgdGVzdCBmb3IgaW50ZXJy
dXB0cy4KClBBVENIIDQ6IE9ubHkgc2V0IHRoZSBpbnRlcnJ1cHRzIHdoaWNoIGFyZSByZXBvcnRl
ZCBhcyBiZWluZyBhdmFpbGFibGUuCgpDaGFuZ2VzIGluIHYzOgotIGZpeGVkIGNvbXBpbGVyIGVy
cm9yIHJlcG9ydGVkIGJ5IGtlcm5lbCB0ZXN0IHJvYm90Ci0gcmVwaHJhc2VkIGNvbW1pdCBtZXNz
YWdlIGFzIHN1Z2dlc3RlZCBieSBKYXJrbyBTYWtraW5lbgotIGFkZGVkIFJldmlld2VkLWJ5IHRh
ZwoKQ2hhbmdlcyBpbiB2MjoKLSByZWJhc2UgYWdhaW5zdCA1LjEyCi0gZnJlZSBpcnEgb24gZXJy
b3IgcGF0aAoKCkxpbm8gU2FuZmlsaXBwbyAoNCk6CiAgdHBtOiBVc2UgYSB0aHJlYWRlZCBpbnRl
cnJ1cHQgaGFuZGxlcgogIHRwbTogU2ltcGxpZnkgbG9jYWxpdHkgaGFuZGxpbmcKICB0cG06IEZp
eCB0ZXN0IGZvciBpbnRlcnJ1cHRzCiAgdHBtOiBPbmx5IGVuYWJsZSBzdXBwb3J0ZWQgaXJxcwoK
IGRyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyAgICAgfCAgNDAgLS0tLS0tLS0KIGRyaXZlcnMv
Y2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAxNzAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmggfCAgIDIgKy0KIGluY2x1ZGUv
bGludXgvdHBtLmggICAgICAgICAgICAgfCAgIDUgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5z
ZXJ0aW9ucygrKSwgMTQ1IGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiA5ZjY3NjcyYTgxN2Vj
MDQ2Zjc1NTRhODg1ZjBmZTBkNjBlMWJmOTlmCi0tIAoyLjMxLjEKCg==
