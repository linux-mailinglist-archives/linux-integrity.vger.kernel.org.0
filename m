Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E731C49B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBPAc4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 19:32:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:37779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPAcz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 19:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613435468;
        bh=LOEB+tn5skN6jy0ltuKCE6/v+M82KwOb5aaBOia/OLc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gpr1XXLCyREauu3NL+9u2OJ6Pa5DesT7hy1nait9QUAFfPUvA+LjcQ9XXGtkRSH7K
         0e+Cc1m5Iv6Gcv013AnegO8XFuLyxPzUaHhVt/nua06c0Ql2aYD0QSbyxpxidFny+X
         cfGUB7/OTvv9+aof6I3kf268w8hgy68ZunPnycH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1lKREj2l73-00Qiui; Tue, 16
 Feb 2021 01:31:08 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v4] tpm: fix reference counting for struct tpm_chip
Date:   Tue, 16 Feb 2021 01:31:00 +0100
Message-Id: <1613435460-4377-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1613435460-4377-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:PcgY/jrp5shv37GovOIzkVnf0kALyY5yNf4KyLIrHFxqU8m6g+p
 HMOw5KeDBkjExO6adF7cgNWPg2nMlMk1hzVC7kQ991J+K4NZzhBqlpMGStjJ/Uprvf/5U5U
 Unq1ExJV5PMh1yWnoszDQn0XUcVXI6dBU/yhwx0zb3SZec21ahy9yfhK9k/F1NGV4qmNQ1d
 ZRX+fMaN7S29aSN/87EMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jsilm6Vawqc=:1XY6PQ26Bpaqv8+nLzsG28
 etDUFWWyenH5xO0ZgdE1PsSAHBVof3ki0ex0mNA/aU+3co3jTVPHie6CSODDtKtQkNBubxdQC
 dKLNnj4kEGf/ws/H/UPfqZ6H9f1DAEqqEb8GK0DmlmpYq2oMcknG735ExPjeoaBf/FZKqATqI
 LoXDo/jcxhLeOZzqlwmadbpBnAhF8H+iXtTsV5b+xSLFWiuxPda/x4FUEYFVauOXTSt2BlVcR
 CWJTgxTTRUXzVLDLGAdiW+9s/zKd7429FTasgO8zhnfFPaH05wNLaTNzSzorustZOf4uOxp20
 TJuets4HMq5pQkIcA64svmOCVSjVdx81flXEYLiir89Ewwyiy1WTnKImLwXuluPF5tRmTAdjp
 4M8hZb3NgMdQbVwoHmW5qq+LSzRql+pXFqr+LQ2C0ArcTV4MVynSl8YpZrP67042grHrqj2JM
 XmRnsYZmnvbpQAw5BaOM5del6BDMT+nfS+fhBIItWeecqZVHZBdqLDzWO8b+uuQHO0+XKugP5
 7wtNHVHM/UWzyamANSgl8RIFgtKIAS3iLOH7CuwKptPmjjHIDC2cR7Zpe1AsLzqPTbZ64WUvs
 hq6kpigoKtdIc6C+gStn+S/PZmpHCZCz4XEsflMPiaIKcJcp1+NlGQluEw63yirxjMry68F48
 5zSRkxToyCuLs7pJImm8omPgcnMa9WuH3xPsHTsNyWFRWTsI37xLjV1WEfZwouQqUzjYcG5z+
 3VSYns7N3iCHYSFvzqn+sKRtdnzVlUEtjbjtM6Nx8sKWQdzCdkqy5uD3H6jd7BhbqVVHjJuzu
 Wre4LLOi0DYujgzHzkvjY7BgDmKEJhHgRcpDoPopyE5qTSWNu6TuttBOJs2+44b4ljMzK0z7z
 LSuuq8Rf07d0fMAnHe3g==
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSBmb2xs
b3dpbmcgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyByZXN1bHRzIGluIGEgcmVmY291bnQgd2Fybmlu
ZzoKCjEuIE9wZW4gZGV2aWNlIC9kZXYvdHBtcm0KMi4gUmVtb3ZlIG1vZHVsZSB0cG1fdGlzX3Nw
aQozLiBXcml0ZSBhIFRQTSBjb21tYW5kIHRvIHRoZSBmaWxlIGRlc2NyaXB0b3Igb3BlbmVkIGF0
IHN0ZXAgMS4KCi0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpXQVJOSU5HOiBD
UFU6IDMgUElEOiAxMTYxIGF0IGxpYi9yZWZjb3VudC5jOjI1IGtvYmplY3RfZ2V0KzB4YTAvMHhh
NApyZWZjb3VudF90OiBhZGRpdGlvbiBvbiAwOyB1c2UtYWZ0ZXItZnJlZS4KTW9kdWxlcyBsaW5r
ZWQgaW46IHRwbV90aXNfc3BpIHRwbV90aXNfY29yZSB0cG0gbWRpb19iY21fdW5pbWFjIGJyY21m
bWFjCnNoYTI1Nl9nZW5lcmljIGxpYnNoYTI1NiBzaGEyNTZfYXJtIGhjaV91YXJ0IGJ0YmNtIGJs
dWV0b290aCBjZmc4MDIxMSB2YzQKYnJjbXV0aWwgZWNkaF9nZW5lcmljIGVjYyBzbmRfc29jX2Nv
cmUgY3JjMzJfYXJtX2NlIGxpYmFlcwpyYXNwYmVycnlwaV9od21vbiBhYzk3X2J1cyBzbmRfcGNt
X2RtYWVuZ2luZSBiY20yNzExX3RoZXJtYWwgc25kX3BjbQpzbmRfdGltZXIgZ2VuZXQgc25kIHBo
eV9nZW5lcmljIHNvdW5kY29yZSBbbGFzdCB1bmxvYWRlZDogc3BpX2JjbTI4MzVdCkNQVTogMyBQ
SUQ6IDExNjEgQ29tbTogaG9sZF9vcGVuIE5vdCB0YWludGVkIDUuMTAuMGxzLW1haW4tZGlydHkg
IzIKSGFyZHdhcmUgbmFtZTogQkNNMjcxMQpbPGMwNDEwYzNjPl0gKHVud2luZF9iYWNrdHJhY2Up
IGZyb20gWzxjMDQwYjU4MD5dIChzaG93X3N0YWNrKzB4MTAvMHgxNCkKWzxjMDQwYjU4MD5dIChz
aG93X3N0YWNrKSBmcm9tIFs8YzEwOTIxNzQ+XSAoZHVtcF9zdGFjaysweGM0LzB4ZDgpCls8YzEw
OTIxNzQ+XSAoZHVtcF9zdGFjaykgZnJvbSBbPGMwNDQ1YTMwPl0gKF9fd2FybisweDEwNC8weDEw
OCkKWzxjMDQ0NWEzMD5dIChfX3dhcm4pIGZyb20gWzxjMDQ0NWFhOD5dICh3YXJuX3Nsb3dwYXRo
X2ZtdCsweDc0LzB4YjgpCls8YzA0NDVhYTg+XSAod2Fybl9zbG93cGF0aF9mbXQpIGZyb20gWzxj
MDg0MzVkMD5dIChrb2JqZWN0X2dldCsweGEwLzB4YTQpCls8YzA4NDM1ZDA+XSAoa29iamVjdF9n
ZXQpIGZyb20gWzxiZjBhNzE1Yz5dICh0cG1fdHJ5X2dldF9vcHMrMHgxNC8weDU0IFt0cG1dKQpb
PGJmMGE3MTVjPl0gKHRwbV90cnlfZ2V0X29wcyBbdHBtXSkgZnJvbSBbPGJmMGE3ZDZjPl0gKHRw
bV9jb21tb25fd3JpdGUrMHgzOC8weDYwIFt0cG1dKQpbPGJmMGE3ZDZjPl0gKHRwbV9jb21tb25f
d3JpdGUgW3RwbV0pIGZyb20gWzxjMDVhN2FjMD5dICh2ZnNfd3JpdGUrMHhjNC8weDNjMCkKWzxj
MDVhN2FjMD5dICh2ZnNfd3JpdGUpIGZyb20gWzxjMDVhN2VlND5dIChrc3lzX3dyaXRlKzB4NTgv
MHhjYykKWzxjMDVhN2VlND5dIChrc3lzX3dyaXRlKSBmcm9tIFs8YzA0MDAxYTA+XSAocmV0X2Zh
c3Rfc3lzY2FsbCsweDAvMHg0YykKRXhjZXB0aW9uIHN0YWNrKDB4YzIyNmJmYTggdG8gMHhjMjI2
YmZmMCkKYmZhMDogICAgICAgICAgICAgICAgICAgMDAwMDAwMDAgMDAwMTA1YjQgMDAwMDAwMDMg
YmVhZmU2NjQgMDAwMDAwMTQgMDAwMDAwMDAKYmZjMDogMDAwMDAwMDAgMDAwMTA1YjQgMDAwMTAz
ZjggMDAwMDAwMDQgMDAwMDAwMDAgMDAwMDAwMDAgYjZmOWMwMDAgYmVhZmU2ODQKYmZlMDogMDAw
MDAwNmMgYmVhZmU2NDggMDAwMTA1NmMgYjZlYjY5NDQKLS0tWyBlbmQgdHJhY2UgZDRiODQwOWRl
ZjliOGIxZiBdLS0tCgpUaGUgcmVhc29uIGZvciB0aGlzIHdhcm5pbmcgaXMgdGhlIGF0dGVtcHQg
dG8gZ2V0IHRoZSBjaGlwLT5kZXYgcmVmZXJlbmNlCmluIHRwbV9jb21tb25fd3JpdGUoKSBhbHRo
b3VnaCB0aGUgcmVmZXJlbmNlIGNvdW50ZXIgaXMgYWxyZWFkeSB6ZXJvLgoKU2luY2UgY29tbWl0
IDg5NzliMDJhYWYxZCAoInRwbTogRml4IHJlZmVyZW5jZSBjb3VudCB0byBtYWluIGRldmljZSIp
IHRoZQpleHRyYSByZWZlcmVuY2UgdXNlZCB0byBwcmV2ZW50IGEgcHJlbWF0dXJlIHplcm8gY291
bnRlciBpcyBuZXZlciB0YWtlbiwKYmVjYXVzZSB0aGUgcmVxdWlyZWQgVFBNX0NISVBfRkxBR19U
UE0yIGZsYWcgaXMgbmV2ZXIgc2V0LgoKRml4IHRoaXMgYnkgbW92aW5nIHRoZSBUUE0gMiBjaGFy
YWN0ZXIgZGV2aWNlIGhhbmRsaW5nIGZyb20KdHBtX2NoaXBfYWxsb2MoKSB0byB0cG1fYWRkX2No
YXJfZGV2aWNlKCkgd2hpY2ggaXMgY2FsbGVkIGF0IGEgbGF0ZXIgcG9pbnQKaW4gdGltZSB3aGVu
IHRoZSBmbGFnIGhhcyBiZWVuIHNldCBpbiBjYXNlIG9mIFRQTTIuCgpDb21taXQgZmRjOTE1Zjdm
NzE5ICgidHBtOiBleHBvc2Ugc3BhY2VzIHZpYSBhIGRldmljZSBsaW5rIC9kZXYvdHBtcm08bj4i
KQphbHJlYWR5IGludHJvZHVjZWQgZnVuY3Rpb24gdHBtX2RldnNfcmVsZWFzZSgpIHRvIHJlbGVh
c2UgdGhlIGV4dHJhCnJlZmVyZW5jZSBidXQgZGlkIG5vdCBpbXBsZW1lbnQgdGhlIHJlcXVpcmVk
IHB1dCBvbiBjaGlwLT5kZXZzIHRoYXQgcmVzdWx0cwppbiB0aGUgY2FsbCBvZiB0aGlzIGZ1bmN0
aW9uLgoKRml4IHRoaXMgYnkgcHV0dGluZyBjaGlwLT5kZXZzIGluIHRwbV9jaGlwX3VucmVnaXN0
ZXIoKS4KCkZpbmFsbHkgbW92ZSB0aGUgbmV3IGltcGxlbWVuYXRpb24gZm9yIHRoZSBUUE0gMiBo
YW5kbGluZyBpbnRvIGEgbmV3CmZ1bmN0aW9uIHRvIGF2b2lkIG11bHRpcGxlIGNoZWNrcyBmb3Ig
dGhlIFRQTV9DSElQX0ZMQUdfVFBNMiBmbGFnIGluIHRoZQpnb29kIGNhc2UgYW5kIGVycm9yIGNh
c2VzLgoKRml4ZXM6IGZkYzkxNWY3ZjcxOSAoInRwbTogZXhwb3NlIHNwYWNlcyB2aWEgYSBkZXZp
Y2UgbGluayAvZGV2L3RwbXJtPG4+IikKRml4ZXM6IDg5NzliMDJhYWYxZCAoInRwbTogRml4IHJl
ZmVyZW5jZSBjb3VudCB0byBtYWluIGRldmljZSIpCkNvLWRldmVsb3BlZC1ieTogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAemllcGUuY2E+ClNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdn
QHppZXBlLmNhPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwotLS0KIGRyaXZlcnMvY2hhci90
cG0vdHBtLWNoaXAuYyB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWNoaXAuYyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtLWNoaXAuYwppbmRleCBkZGFlY2ViLi40NGNhYzNhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMKKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5j
CkBAIC0zNDQsNyArMzQ0LDYgQEAgc3RydWN0IHRwbV9jaGlwICp0cG1fY2hpcF9hbGxvYyhzdHJ1
Y3QgZGV2aWNlICpwZGV2LAogCWNoaXAtPmRldl9udW0gPSByYzsKIAogCWRldmljZV9pbml0aWFs
aXplKCZjaGlwLT5kZXYpOwotCWRldmljZV9pbml0aWFsaXplKCZjaGlwLT5kZXZzKTsKIAogCWNo
aXAtPmRldi5jbGFzcyA9IHRwbV9jbGFzczsKIAljaGlwLT5kZXYuY2xhc3MtPnNodXRkb3duX3By
ZSA9IHRwbV9jbGFzc19zaHV0ZG93bjsKQEAgLTM1MiwzOSArMzUxLDIwIEBAIHN0cnVjdCB0cG1f
Y2hpcCAqdHBtX2NoaXBfYWxsb2Moc3RydWN0IGRldmljZSAqcGRldiwKIAljaGlwLT5kZXYucGFy
ZW50ID0gcGRldjsKIAljaGlwLT5kZXYuZ3JvdXBzID0gY2hpcC0+Z3JvdXBzOwogCi0JY2hpcC0+
ZGV2cy5wYXJlbnQgPSBwZGV2OwotCWNoaXAtPmRldnMuY2xhc3MgPSB0cG1ybV9jbGFzczsKLQlj
aGlwLT5kZXZzLnJlbGVhc2UgPSB0cG1fZGV2c19yZWxlYXNlOwotCS8qIGdldCBleHRyYSByZWZl
cmVuY2Ugb24gbWFpbiBkZXZpY2UgdG8gaG9sZCBvbgotCSAqIGJlaGFsZiBvZiBkZXZzLiAgVGhp
cyBob2xkcyB0aGUgY2hpcCBzdHJ1Y3R1cmUKLQkgKiB3aGlsZSBjZGV2cyBpcyBpbiB1c2UuICBU
aGUgY29ycmVzcG9uZGluZyBwdXQKLQkgKiBpcyBpbiB0aGUgdHBtX2RldnNfcmVsZWFzZSAoVFBN
MiBvbmx5KQotCSAqLwotCWlmIChjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikKLQkJ
Z2V0X2RldmljZSgmY2hpcC0+ZGV2KTsKLQogCWlmIChjaGlwLT5kZXZfbnVtID09IDApCiAJCWNo
aXAtPmRldi5kZXZ0ID0gTUtERVYoTUlTQ19NQUpPUiwgVFBNX01JTk9SKTsKIAllbHNlCiAJCWNo
aXAtPmRldi5kZXZ0ID0gTUtERVYoTUFKT1IodHBtX2RldnQpLCBjaGlwLT5kZXZfbnVtKTsKIAot
CWNoaXAtPmRldnMuZGV2dCA9Ci0JCU1LREVWKE1BSk9SKHRwbV9kZXZ0KSwgY2hpcC0+ZGV2X251
bSArIFRQTV9OVU1fREVWSUNFUyk7Ci0KIAlyYyA9IGRldl9zZXRfbmFtZSgmY2hpcC0+ZGV2LCAi
dHBtJWQiLCBjaGlwLT5kZXZfbnVtKTsKIAlpZiAocmMpCiAJCWdvdG8gb3V0OwotCXJjID0gZGV2
X3NldF9uYW1lKCZjaGlwLT5kZXZzLCAidHBtcm0lZCIsIGNoaXAtPmRldl9udW0pOwotCWlmIChy
YykKLQkJZ290byBvdXQ7CiAKIAlpZiAoIXBkZXYpCiAJCWNoaXAtPmZsYWdzIHw9IFRQTV9DSElQ
X0ZMQUdfVklSVFVBTDsKIAogCWNkZXZfaW5pdCgmY2hpcC0+Y2RldiwgJnRwbV9mb3BzKTsKLQlj
ZGV2X2luaXQoJmNoaXAtPmNkZXZzLCAmdHBtcm1fZm9wcyk7CiAJY2hpcC0+Y2Rldi5vd25lciA9
IFRISVNfTU9EVUxFOwotCWNoaXAtPmNkZXZzLm93bmVyID0gVEhJU19NT0RVTEU7CiAKIAlyYyA9
IHRwbTJfaW5pdF9zcGFjZSgmY2hpcC0+d29ya19zcGFjZSwgVFBNMl9TUEFDRV9CVUZGRVJfU0la
RSk7CiAJaWYgKHJjKSB7CkBAIC0zOTYsNyArMzc2LDYgQEAgc3RydWN0IHRwbV9jaGlwICp0cG1f
Y2hpcF9hbGxvYyhzdHJ1Y3QgZGV2aWNlICpwZGV2LAogCXJldHVybiBjaGlwOwogCiBvdXQ6Ci0J
cHV0X2RldmljZSgmY2hpcC0+ZGV2cyk7CiAJcHV0X2RldmljZSgmY2hpcC0+ZGV2KTsKIAlyZXR1
cm4gRVJSX1BUUihyYyk7CiB9CkBAIC00MzEsNiArNDEwLDQ2IEBAIHN0cnVjdCB0cG1fY2hpcCAq
dHBtbV9jaGlwX2FsbG9jKHN0cnVjdCBkZXZpY2UgKnBkZXYsCiB9CiBFWFBPUlRfU1lNQk9MX0dQ
TCh0cG1tX2NoaXBfYWxsb2MpOwogCitzdGF0aWMgaW50IHRwbV9hZGRfdHBtMl9jaGFyX2Rldmlj
ZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCit7CisJaW50IHJjOworCisJZGV2aWNlX2luaXRpYWxp
emUoJmNoaXAtPmRldnMpOworCWNoaXAtPmRldnMucGFyZW50ID0gY2hpcC0+ZGV2LnBhcmVudDsK
KwljaGlwLT5kZXZzLmNsYXNzID0gdHBtcm1fY2xhc3M7CisKKwlyYyA9IGRldl9zZXRfbmFtZSgm
Y2hpcC0+ZGV2cywgInRwbXJtJWQiLCBjaGlwLT5kZXZfbnVtKTsKKwlpZiAocmMpCisJCWdvdG8g
b3V0X3B1dF9kZXZzOworCS8qCisJICogZ2V0IGV4dHJhIHJlZmVyZW5jZSBvbiBtYWluIGRldmlj
ZSB0byBob2xkIG9uIGJlaGFsZiBvZiBkZXZzLgorCSAqIFRoaXMgaG9sZHMgdGhlIGNoaXAgc3Ry
dWN0dXJlIHdoaWxlIGNkZXZzIGlzIGluIHVzZS4gVGhlCisJICogY29ycmVzcG9uZGluZyBwdXQg
aXMgaW4gdGhlIHRwbV9kZXZzX3JlbGVhc2UuCisJICovCisJZ2V0X2RldmljZSgmY2hpcC0+ZGV2
KTsKKwljaGlwLT5kZXZzLnJlbGVhc2UgPSB0cG1fZGV2c19yZWxlYXNlOworCWNoaXAtPmRldnMu
ZGV2dCA9CisJCU1LREVWKE1BSk9SKHRwbV9kZXZ0KSwgY2hpcC0+ZGV2X251bSArIFRQTV9OVU1f
REVWSUNFUyk7CisJY2Rldl9pbml0KCZjaGlwLT5jZGV2cywgJnRwbXJtX2ZvcHMpOworCWNoaXAt
PmNkZXZzLm93bmVyID0gVEhJU19NT0RVTEU7CisKKwlyYyA9IGNkZXZfZGV2aWNlX2FkZCgmY2hp
cC0+Y2RldnMsICZjaGlwLT5kZXZzKTsKKwlpZiAocmMpIHsKKwkJZGV2X2VycigmY2hpcC0+ZGV2
cywKKwkJCSJ1bmFibGUgdG8gY2Rldl9kZXZpY2VfYWRkKCkgJXMsIG1ham9yICVkLCBtaW5vciAl
ZCwgZXJyPSVkXG4iLAorCQkJZGV2X25hbWUoJmNoaXAtPmRldnMpLCBNQUpPUihjaGlwLT5kZXZz
LmRldnQpLAorCQkJTUlOT1IoY2hpcC0+ZGV2cy5kZXZ0KSwgcmMpOworCQlnb3RvIG91dF9wdXRf
ZGV2czsKKwl9CisKKwlyZXR1cm4gMDsKKworb3V0X3B1dF9kZXZzOgorCXB1dF9kZXZpY2UoJmNo
aXAtPmRldnMpOworCisJcmV0dXJuIHJjOworfQorCiBzdGF0aWMgaW50IHRwbV9hZGRfY2hhcl9k
ZXZpY2Uoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogewogCWludCByYzsKQEAgLTQ0NSwxNCArNDY0
LDkgQEAgc3RhdGljIGludCB0cG1fYWRkX2NoYXJfZGV2aWNlKHN0cnVjdCB0cG1fY2hpcCAqY2hp
cCkKIAl9CiAKIAlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpIHsKLQkJcmMg
PSBjZGV2X2RldmljZV9hZGQoJmNoaXAtPmNkZXZzLCAmY2hpcC0+ZGV2cyk7Ci0JCWlmIChyYykg
ewotCQkJZGV2X2VycigmY2hpcC0+ZGV2cywKLQkJCQkidW5hYmxlIHRvIGNkZXZfZGV2aWNlX2Fk
ZCgpICVzLCBtYWpvciAlZCwgbWlub3IgJWQsIGVycj0lZFxuIiwKLQkJCQlkZXZfbmFtZSgmY2hp
cC0+ZGV2cyksIE1BSk9SKGNoaXAtPmRldnMuZGV2dCksCi0JCQkJTUlOT1IoY2hpcC0+ZGV2cy5k
ZXZ0KSwgcmMpOwotCQkJcmV0dXJuIHJjOwotCQl9CisJCXJjID0gdHBtX2FkZF90cG0yX2NoYXJf
ZGV2aWNlKGNoaXApOworCQlpZiAocmMpCisJCQlnb3RvIGRlbF9jZGV2OwogCX0KIAogCS8qIE1h
a2UgdGhlIGNoaXAgYXZhaWxhYmxlLiAqLwpAQCAtNDYwLDYgKzQ3NCwxMCBAQCBzdGF0aWMgaW50
IHRwbV9hZGRfY2hhcl9kZXZpY2Uoc3RydWN0IHRwbV9jaGlwICpjaGlwKQogCWlkcl9yZXBsYWNl
KCZkZXZfbnVtc19pZHIsIGNoaXAsIGNoaXAtPmRldl9udW0pOwogCW11dGV4X3VubG9jaygmaWRy
X2xvY2spOwogCisJcmV0dXJuIDA7CisKK2RlbF9jZGV2OgorCWNkZXZfZGV2aWNlX2RlbCgmY2hp
cC0+Y2RldiwgJmNoaXAtPmRldik7CiAJcmV0dXJuIHJjOwogfQogCkBAIC02NDAsOCArNjU4LDEw
IEBAIHZvaWQgdHBtX2NoaXBfdW5yZWdpc3RlcihzdHJ1Y3QgdHBtX2NoaXAgKmNoaXApCiAJaWYg
KElTX0VOQUJMRUQoQ09ORklHX0hXX1JBTkRPTV9UUE0pKQogCQlod3JuZ191bnJlZ2lzdGVyKCZj
aGlwLT5od3JuZyk7CiAJdHBtX2Jpb3NfbG9nX3RlYXJkb3duKGNoaXApOwotCWlmIChjaGlwLT5m
bGFncyAmIFRQTV9DSElQX0ZMQUdfVFBNMikKKwlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9G
TEFHX1RQTTIpIHsKIAkJY2Rldl9kZXZpY2VfZGVsKCZjaGlwLT5jZGV2cywgJmNoaXAtPmRldnMp
OworCQlwdXRfZGV2aWNlKCZjaGlwLT5kZXZzKTsKKwl9CiAJdHBtX2RlbF9jaGFyX2RldmljZShj
aGlwKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHRwbV9jaGlwX3VucmVnaXN0ZXIpOwotLSAKMi43
LjQKCg==
