Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEA51F6F0
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiEIIq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiEIIOw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 04:14:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415B185CBF;
        Mon,  9 May 2022 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652083625;
        bh=M4uiBJ0SrRm3ugvJXz12yggQ3vN5GTXqnSYLxrQ/oHs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=b/4Pa0oliyKAEasDWKOIFAeByXhAfC4XtPfN3dOlJHAnb4Mc0GJUWxCQ32pwineAl
         kcU+BpdIrS3GQVAmMNUUNm8Pod4iLRir/2ShxpVP/LWpB9358qUpKl2lo0hf2qqH4B
         edzuZ526y3lcfMIN0lXEfuPI+eaubtZzsXOJTBJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([46.223.3.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1nSCJU2Lnl-00MKuy; Mon, 09
 May 2022 10:07:05 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v4 0/6] TPM irq fixes
Date:   Mon,  9 May 2022 10:05:53 +0200
Message-Id: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:jd1zsKpJOfv6QwsNpOuzhGc8NRM3R5nkXHVqzjdmH7YEXNIU7ne
 la/ZV2IY9Q74+00orv0t2MWAahRMJIDjQ3cSaW9eegv7N/uUUml30W5gcp1X/fPDSwdKoR7
 K3gu732JFMsodXAgAFcEL8MBrG7b1ShzMV8H2hYQ5fVG1xkMxfJ7DywA0ZNk/CsazbFQg9P
 SCXsn80M2nwHPzO6bUf/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JkI4FvcRRfE=:ya3qy+PY8LWKx7E8pZIhrQ
 4K0lhxQNPgpTXbrL5oIoGMUqmTUoz6Ov0OKQ381Xyga8FJmN7/vzewraNyMXFT9aBA2cPoLEB
 gZrRySJhPGv46WizbHrRrlNvTNd+iKL+ZIXEYib9Y0Yz2hfwt47yWprKuLXzs4TAMrQZOFlsj
 UVWHaUk/goIVV/EZusfPd9YmoKszYWuNHoR57FfarLt7buxj711GnMsIPt8M6ybRIpN5wXcBY
 Ncd3FQxZBZqYT+xbzvak3UNK2MnhsjnVOktajgn3ajVA6DoBQsXPdaOtY+Fdr4anaFRU2kkoK
 wGags94RP1YXwrOW8Jq3O+xOWR+o1S/iyz9ev+AWm3e5NVvnUCbXmn8UvtOL/2VtFLyfnwMbr
 51Rrs6VaEstH3R5VcyhCIKcwjUN34Ayn6Jqf4MjVUPqbpD5+BG+zJzsDWGkL5Xsp9ooCVMkaU
 7fnMRVIyvmwgzcz85NlTuAVxj9YSfh8rMc617GJ4V7FKjzYNm8ssbqW7W3Makc5mVlMJPOINW
 6At4RQpo7QD1rkFzXuerXQgUrCoGmkgQN07KmhJ5P5VTNga6A8DyU0x5p9peVdNwzfqBp/Lhu
 XxTrS2QezZgPmLdnRg53Y3qqG8lj7EuK/Ayc3+318oMY+oyzlD+cNRj6WpXsWah8LukEY6GFs
 AUspHoN+2uDdfalqaA2ynqpxYjyg/frCj02AgydPYNHF9uwr7gJd06TVAwf/norQuy4rRXIzA
 M4FsFJcJyIcP6iwbfAhW92ClWcx7r/+U0FMjDxAxF9wDlap7gaBLymJ4LHnxMaSQieryef14D
 5WtRGhcC9/ns5s4UaDRWwS7aY7WoLXqQio8WokhUkiA0jIeAQWlYFz7/HoAplfWeLYbmyLFqV
 PjMyGGvE+k4FEiLnUmHjfGPLJB99+UJh4RUy3i984EoBWWmxq6Z8b0okZXM0UySDKOamFe1d7
 56/1aD/T0r3ppiiNVr/uKOYmZsnYXi1GIbWn/hqGJu3n5mt/PDfQDhtGKW/KmMYpI8rxMEn4F
 OhFHJ6XxloPGcYDJes0p8F12V0280JiQlIV8xUBCYVziSTUsmm1HU7BDRDgVyfIchNIbZOX3c
 BHZrerWgZMP5I0=
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MIME_BASE64_TEXT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhpcyBzZXJpZXMgZml4ZXMgaXNzdWVzIGFyb3VuZCB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIGlu
IHRoZSBUUE0gVElTIGNvcmUuCgpQYXRjaCAxOgpSZXF1ZXN0IHRocmVhZGVkIGludGVycnVwdCBo
YW5kbGVyIGZvciBTUEkuIFRoaXMgaXMgbmVlZGVkIHNpbmNlIFNQSSB1c2VzIGEKbXV0ZXggZm9y
IGRhdGEgdHJhbnNtaXNzaW9uIGFuZCBzaW5jZSB3ZSBleGNoYW5nZSBkYXRhIHZpYSBTUEkgaW50
IHRoZSBpcnEKaGFuZGxlciB3ZSBuZWVkIGEgc2xlZXBhYmxlIGNvbnRleHQuCgpQYXRjaCAyOgpN
YWtlIGxvY2FsaXR5IGhhbmRsaW5nIHNpbXBsZXIgYnkgb25seSBjbGFpbWluZyBpdCBhdCBkcml2
ZXIgc3RhcnR1cCBhbmQKcmVsZWFzaW5nIGl0IGF0IGRyaXZlciBzaHV0ZG93bi4KClBhdGNoIDM6
CkVuYWJsZSB0aGUgaXJxIHRlc3Qgd2hpY2ggaXMgYWx3YXlzIHNraXBwZWQgaW4gdGhlIGN1cnJl
bnQgY29kZS4KClBhdGNoIDQ6CkZpeCB0aGUgaXJxIHRlc3QgYnkgZW5zdXJpbmcgQ1BVIGNhY2hl
IGNvaGVyZW5jeSB3aGVuIHNldHRpbmcgdGhlIGlycSB0ZXN0CmNvbmRpdGlvbiBvbiBvbmUgYW5k
IGNoZWNraW5nIGl0IG9uIGFub3RoZXIgQ1BVLgoKUGF0Y2ggNToKTW92ZSB0aGUgaXJxIHRlc3Qg
YW5kIHRoZSBjaGVjayBmb3IgaXJxIHRlc3QgZnJvbSB0cG1fdGlzX3NlbmQoKSB0bwp0cG1fdGlz
X3Byb2JlX2lycV9zaW5nbGUoKSBzbyB0aGUgY2hlY2sgaGFzIG5vdCB0byBiZSBkb25lIGZvciBl
YWNoIGRhdGEKdHJhbnNtaXNzaW9uLgoKUGF0Y2ggNjoKSW5zdGVhZCBvZiBibGluZGx5IHRyeWlu
ZyB0byBlbmFibGUgYWxsIHBvc3NpYmxlIGludGVycnVwdHMsIHVzZSB0aGUgcmVzdWx0CmZyb20g
dGhlIGNhcGFiaWxpdHkgcXVlcnkgYW5kIHJlcXVlc3Qgb25seSB0aGUgaW50ZXJydXB0cyB0aGF0
IGFyZSBhY3R1YWxseQpzdXBwb3J0ZWQuCgoKQ2hhbmdlcyBpbiB2NDoKLSBvbmx5IHJlcXVlc3Qg
dGhyZWFkZWQgaXJxIGluIGNhc2Ugb2YgU1BJIGFzIHJlcXVlc3RlZCBieSBKYXJrby4KLSByZWlt
cGxlbWVudCBwYXRjaCAyIHRvIGxpbWl0IGxvY2FsaXR5IGhhbmRsaW5nIGNoYW5nZXMgdG8gdGhl
IFRJUyBjb3JlLgotIHNlcGFyYXRlIGZpeGVzIGZyb20gY2xlYW51cHMgYXMgcmVxdWVzdGVkIGJ5
IEphcmtvLgotIHJlcGhyYXNlIGNvbW1pdCBtZXNzYWdlcyAKCkNoYW5nZXMgaW4gdjM6Ci0gZml4
ZWQgY29tcGlsZXIgZXJyb3IgcmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3QKLSByZXBocmFz
ZWQgY29tbWl0IG1lc3NhZ2UgYXMgc3VnZ2VzdGVkIGJ5IEphcmtvIFNha2tpbmVuCi0gYWRkZWQg
UmV2aWV3ZWQtYnkgdGFnCgpDaGFuZ2VzIGluIHYyOgotIHJlYmFzZSBhZ2FpbnN0IDUuMTIKLSBm
cmVlIGlycSBvbiBlcnJvciBwYXRoCgoKTGlubyBTYW5maWxpcHBvICg2KToKICB0cG0sIHRwbV90
aXNfc3BpOiBSZXF1ZXN0IHRocmVhZGVkIGlycQogIHRwbSwgdHBtX3RpczogQ2xhaW0gYW5kIHJl
bGVhc2UgbG9jYWxpdHkgb25seSBvbmNlCiAgdHBtLCB0cG1fdGlzOiBlbmFibGUgaXJxIHRlc3QK
ICB0cG0sIHRwbV90aXM6IGF2b2lkIENQVSBjYWNoZSBpbmNvaGVyZW5jeSBpbiBpcnEgdGVzdAog
IHRwbSwgdHBtX3RpczogTW92ZSBpcnEgdGVzdCBmcm9tIHRwbV90aXNfc2VuZCgpIHRvCiAgICB0
cG1fdGlzX3Byb2JlX2lycV9zaW5nbGUoKQogIHRwbSwgdHBtX3RpczogT25seSBlbmFibGUgc3Vw
cG9ydGVkIElSUXMKCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jICAgICB8IDIwMiAr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29y
ZS5oICAgICB8ICAgOCArLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX3NwaV9tYWluLmMgfCAg
IDUgKy0KIDMgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKSwgMTE5IGRlbGV0aW9ucygt
KQoKCmJhc2UtY29tbWl0OiBmZTI3ZDE4OWUzZjQyZTMxZDNjODIyM2Q1ZGFlZDcyODVlMzM0YzVl
Ci0tIAoyLjM2LjAKCg==
