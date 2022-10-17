Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E548601DF7
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJQX6P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJQX6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 19:58:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7C27E03A;
        Mon, 17 Oct 2022 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666051071;
        bh=A5gzN4mXM9p6SpYjvt1lyWJmsiJr8fpb+zizXUo+H9o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OfZrc2OxiuEIW1kDYkBDMHzkpB3HTAQ+mPmYb2XP4xPLjOwrYP/A2hkKsHC0fgqZV
         Hp4LzQ8YZnADNg+p2hF1R52tC1+h5KuhN3uwdu89G+IeUcXv4bEzdFVJjTe7EUxOiz
         1JllyscdKZTXFzqezk8a/SVTJFYjjwkD3qMMJsW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.speedport.ip ([84.162.5.241]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5G9t-1p9MfC2mTl-011Bad; Tue, 18
 Oct 2022 01:57:51 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v8 04/11] tpm, tmp_tis: Claim locality before writing interrupt registers
Date:   Tue, 18 Oct 2022 01:57:25 +0200
Message-Id: <20221017235732.10145-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:RLlc1AfZ1NIbHfi1JEu1isUf4ptuCNEd04D0B5dUC/z/3eXyz30
 Or/zGIJ+DYVhZskfDa6VWbUU5MpzAZaFb9iBen8AqKsqP7KO91laDvNHg09GuJWmj0ioK1/
 fgHEflm+WOIPDsSXcEkOBcferdR23EL6tq0I6HMxniGTy5q+Dbpr1aEtUfuIZDphpnc+GhH
 VYnitsF3deV467lOHNGfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V3UvChKgQuU=:g/DpbxX08A2gQ2Wu4Qhkkv
 Rkqh0Lvachxbd/ZSY5hArZ5Wfe8JmuSShzwVKY215UKHaZFlL+5HmPZosvWa44bnNWGvJn9VL
 f78VhrXXzvRHt4fTy2F1qf2m3vUJfJ/dGs2vcB1af1kcfUyoKHUkej4mxIe+11wuco6vfEUNR
 XDdesq+ct+TZXHuUbDdlsSnREnY2U9GfKrfvDPrYGCJDYjfGvqNeUsiuTVMtWmJA2adJk28AW
 X7o1WUg15OImaJ7W4pmqDoZMMIP3DKQYW4ujrpNh2yEFnadAlAY+PRwubzReIlpaTtNaF6oYo
 sM3IpTfU40x+X9MAYATZJBlSQQhGYDQZPQUVGpsfixkuvlRBsMyW2Z6mtZFHa+yWBvR2iZWLG
 QqqMpUULa9xPv+FZrPLOsY/glWbg9zVZmGKbZwwONfQqbGLE1R3c+73QvuJsm3yxG0Yw4ow+4
 p2EsiIICvx9LHSwNCVGWapJGF4fnelsLulCQcaRYPOaZvDhzdvWywKCA/v+WMjhodlZAFpz53
 OPuuFH9PKVFrX5xnyRV8IgLNedYHwfLKHNMSCjfPPL0pJ1bn5JXwI76zBmW3F2iE1DoMlqLgu
 Cgl8e5paHriNRcM3HOM8r5ePQ5iyOoZdrVtJWbIzzPOvhvr5l6BXj6bxvou6XjxpMz6dlZN3f
 0C5hxrxrt3h9jAuuWj2Ugzb2KSxMpkenccqZMwSEYUFK2VhsnfbbJ0DxZxlCh5uzUKDicQKZq
 YkFmDe/tWHCN9gTbbaDjNrD45wVaxEFJRRSMHIct1QXRgDivpU0zbov8Xoz4qBgskLoB/gtVO
 pPtEtbWrSwaT63Axrhhpw14MZRXtqbfhcx7k5VYkFX1bArR/y1vwb/RVVqzOUP/KyIVhbicPp
 oJoa4uVPUEMBrjWbDWQyHODu6xBr1+WCe2kNi28nDKaAY2yqXxjPMU3+WHgQOOmD+nMnLXiVK
 ZGKHbb2axGpagNzq+qoY3zjVPd46Ngxx5oo64FmSUrWk80iS+W9b+ZoUr4eC5EHhvwt+zXX40
 MFswVuQ+afn0zDGqXCaO1K4Mo8lyecBALoMZvjhcM/+gKGD0+h3OpbwmI7CPpXM8GRAmvyloE
 zckWHc1h5WN3QklIYJStk6bTC4Q4Lky4w0mnaiplgtEqBIRldIDmJS95Hy0/3mOnw+GSgxE0M
 2Ml4QLdIQE26348axkS3cI5zPX/VfNKTyeRPIYC9jS/rCuu3pGVn2AVE6YTLxRpxBqE8ROTes
 fx4g5IyRmRObvKsaXUy8tG/6L6C96bdSdyc053p0b+BIzQA6S1ZtsdwsPuJ/GYROABzwkeNDh
 zuLgEE/exOebOGR3FOO7xt9Cp4/B7NrzHPLVfBbZjJiMY9nku11o2jHnCGMjP4lS8alMq69H2
 JGrosVQbgUzXTSdnD+u+atXRRzVigXuuIErIpPI3RhDq88ZdrYAPzf+7ZGqVt1TzVX1o0s241
 3ePsTQGtcjYJJqoPDspmG7x2BmBEfN4Zv3hbJVlcTwxiiwco/lzMwz0kTmvaC2EJfSvpDhU/b
 sMJJuUl1pW04lkSs5I/EGGWCnX/ZRiAQb/LXr4aMbk09Z
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkluIHRwbV90
aXNfcHJvYmVfc2luZ2xlX2lycSgpIGludGVycnVwdCByZWdpc3RlcnMgVFBNX0lOVF9WRUNUT1Is
ClRQTV9JTlRfU1RBVFVTIGFuZCBUUE1fSU5UX0VOQUJMRSBhcmUgbW9kaWZpZWQgdG8gc2V0dXAg
dGhlIGludGVycnVwdHMuCkN1cnJlbnRseSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBkb25lIHdp
dGhvdXQgaG9sZGluZyBhIGxvY2FsaXR5IHRodXMgdGhleQpoYXZlIG5vIGVmZmVjdC4gRml4IHRo
aXMgYnkgY2xhaW1pbmcgdGhlIChkZWZhdWx0KSBsb2NhbGl0eSBiZWZvcmUgdGhlCnJlZ2lzdGVy
cyBhcmUgd3JpdHRlbi4KClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxp
cHBvQGt1bmJ1cy5jb20+ClJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJu
ZWwub3JnPgpUZXN0ZWQtYnk6IE1pY2hhZWwgTmlld8O2aG5lciA8bGludXhAbW5pZXdvZWhuZXIu
ZGU+Ci0tLQogZHJpdmVycy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYyB8IDI1ICsrKysrKysrKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9k
cml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDYwM2I4MmNhNTZkYS4uNTIyMDVh
MWZlZTllIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBi
L2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc3MCwzMCArNzcwLDQ1IEBAIHN0
YXRpYyBpbnQgdHBtX3Rpc19wcm9iZV9pcnFfc2luZ2xlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwg
dTMyIGludG1hc2ssCiAJfQogCXByaXYtPmlycSA9IGlycTsKIAorCXJjID0gcmVxdWVzdF9sb2Nh
bGl0eShjaGlwLCAwKTsKKwlpZiAocmMgPCAwKQorCQlyZXR1cm4gcmM7CisKIAlyYyA9IHRwbV90
aXNfcmVhZDgocHJpdiwgVFBNX0lOVF9WRUNUT1IocHJpdi0+bG9jYWxpdHkpLAogCQkJICAgJm9y
aWdpbmFsX2ludF92ZWMpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNl
X2xvY2FsaXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCXJj
ID0gdHBtX3Rpc193cml0ZTgocHJpdiwgVFBNX0lOVF9WRUNUT1IocHJpdi0+bG9jYWxpdHkpLCBp
cnEpOwotCWlmIChyYyA8IDApCisJaWYgKHJjIDwgMCkgeworCQlyZWxlYXNlX2xvY2FsaXR5KGNo
aXAsIHByaXYtPmxvY2FsaXR5KTsKIAkJcmV0dXJuIHJjOworCX0KIAogCXJjID0gdHBtX3Rpc19y
ZWFkMzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJpdi0+bG9jYWxpdHkpLCAmaW50X3N0YXR1cyk7
Ci0JaWYgKHJjIDwgMCkKKwlpZiAocmMgPCAwKSB7CisJCXJlbGVhc2VfbG9jYWxpdHkoY2hpcCwg
cHJpdi0+bG9jYWxpdHkpOwogCQlyZXR1cm4gcmM7CisJfQogCiAJLyogQ2xlYXIgYWxsIGV4aXN0
aW5nICovCiAJcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9TVEFUVVMocHJpdi0+
bG9jYWxpdHkpLCBpbnRfc3RhdHVzKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJ
cmVsZWFzZV9sb2NhbGl0eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9
CiAKIAkvKiBUdXJuIG9uICovCiAJcmMgPSB0cG1fdGlzX3dyaXRlMzIocHJpdiwgVFBNX0lOVF9F
TkFCTEUocHJpdi0+bG9jYWxpdHkpLAogCQkJICAgICBpbnRtYXNrIHwgVFBNX0dMT0JBTF9JTlRf
RU5BQkxFKTsKLQlpZiAocmMgPCAwKQorCWlmIChyYyA8IDApIHsKKwkJcmVsZWFzZV9sb2NhbGl0
eShjaGlwLCBwcml2LT5sb2NhbGl0eSk7CiAJCXJldHVybiByYzsKKwl9CiAKKwlyZWxlYXNlX2xv
Y2FsaXR5KGNoaXAsIHByaXYtPmxvY2FsaXR5KTsKIAljbGVhcl9iaXQoVFBNX1RJU19JUlFfVEVT
VEVELCAmcHJpdi0+ZmxhZ3MpOwogCiAJLyogR2VuZXJhdGUgYW4gaW50ZXJydXB0IGJ5IGhhdmlu
ZyB0aGUgY29yZSBjYWxsIHRocm91Z2ggdG8KLS0gCjIuMzYuMQoK
