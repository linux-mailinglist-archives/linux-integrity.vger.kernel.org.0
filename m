Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D5F637AA8
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKXN5E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 08:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiKXN44 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 08:56:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0151165B7;
        Thu, 24 Nov 2022 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669298175; bh=tNxzriKju7X09wVvY3INkMxvkZLtq7M5+64P/eal/h4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ays7wa/uQDWJNn3ep6L/CDUcb4ZbmIcHpU+KmoMdvXBjKvK83GtjGEsyvd2qG0sIQ
         jXqfKpVOGzay688FLBVMEJRiKT2OV7HQ36O5Mkn6qQaVq7Zp7zHHdQX1bM+Qp/Lvjk
         P3RigZ7k0WeJWKs7u/gRcPTBe6BYpTP1ttD+kc4A5gPfl86ZDL0UcfGAVpnoMIGAn0
         lN7SXSViEGsg6FMjYIMhIA1UYbXzdgnY+F3ixchd/bWFnHSKBju6+SvJPwT0XgqAHv
         bED6lKWY+e10CibuVdHMKIFk2XgZebcpcIpYr+0GoLrqN2ev56/+dqlfI0U51PgQD6
         xWyhCwaiuS+ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.7.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe9s-1oaSkq35Hy-00Nkbe; Thu, 24
 Nov 2022 14:56:14 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH v11 14/14] tpm, tpm_tis: Enable interrupt test
Date:   Thu, 24 Nov 2022 14:55:38 +0100
Message-Id: <20221124135538.31020-15-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:xfdO2tuW/H6iYYoumuTl2JI/87L4z6XQerQt8f+R27hsPCrO64Z
 JwwfgAMboMKyAW+te2wxvETCWMQl9n7oGkgVUgttVuzOj8mppqb7n8fDCtqi3gU1NkCuN4I
 8LP8lBZUixMLA2IPpHG9hkg1CYcxXkcQZMY7SDAVvbLzkKFnCKKLNHH388WCpvJ3+iHELmx
 06AlFwwV950PY1Vn1fsLQ==
UI-OutboundReport: notjunk:1;M01:P0:1X7tueyk1qI=;cI7BBTNCszsaJNj810LcBY0NURn
 uUcFyWg8EsV5Iz5QF46XdeZhniFC8uMWGw4gXOHAXbzn+q8gbtvSsKKV8eY4hK7RlJnn9sRSg
 2Ug/tnVjG+HSmx+j0z5Jii9oE/m7TF16M41Qt4mmYGiWEhWk+pMaiSwHSyHDmNnfGHBtr5QE3
 aRmggsoxFYZGsrlmfRojCDjLiASKcpDPrwFqhAmievr+2HXfPCf2ACnTjrqaqgsg75FrQ1UGg
 dLNV+2O3sfYKhceOcfAkqr7XJtQNksALkXcxOhUOx3mWWGATFG1byaXFGkCac1Zfu4gUSAxiB
 23Z7j60SLUP+vqMLOqXMObULp2xJr/DkpYzpFkcnR5FzirSHIqUs7Pz+68xJDCEOODT8zaiwv
 OTMQlt8uwu6Qu87Mu++czibfjbBzRh9be+rjxCNbMZd3jZoyalXQcLtE3M8H0Nyf8/1JF2sys
 UKUnrQ9qUyPv/RVFD10Au9zn/+i2+ZEzYFjjUaO2czM2lHwtd89NiKaipU+WRBl3zeZC/iK7o
 jxgeWrECkTBMowMMQ2ReCtRE6Zbn310uahyYwGzdxlVcAghq/nZcTfz8eu4Ouwx6xwZ7psZgU
 2mfmUyLmxOv64aKvNOUIaQvqWdndXP96qZkIRgdzix4FVQBFgCOSwoMH5TzxHuMO+X4fcEbSL
 lf17I0Cdkj27nlqBJci2Ps12+NnlmUNf7vlshbiXT5R1WUXs/kZBxA54+N9kALIQyKuWScJvf
 4Z1fdDg8JMBuw7INIZ1c1a4DxQ4SFJQySCkDa7/+1fxNSn0qMYwT9Cc98EJHoysAjzlSHo8EF
 Epy6CrgVvaNX5HwwH6bC0WDZ5UqMxEYDPV0H3gOvMA3aKIxoZTcyytTP3wju1pYUPXCHsu3G7
 jsW4BqTXcX/5Ot24Wdww+BJCDeUCNE4N+sesPYPF8FkSqU1Qps1oNWjWpnQt56Vd4tkLRWerF
 6GPs7ot75nofwZMUtwA+18S73Co=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClRoZSB0ZXN0
IGZvciBpbnRlcnJ1cHRzIGluIHRwbV90aXNfc2VuZCgpIGlzIHNraXBwZWQgaWYgdGhlIGZsYWcK
VFBNX0NISVBfRkxBR19JUlEgaXMgbm90IHNldC4gU2luY2UgdGhlIGN1cnJlbnQgY29kZSBuZXZl
ciBzZXRzIHRoZSBmbGFnCmluaXRpYWxseSB0aGUgdGVzdCBpcyBuZXZlciBleGVjdXRlZC4KCkZp
eCB0aGlzIGJ5IHNldHRpbmcgdGhlIGZsYWcgaW4gdHBtX3Rpc19nZW5faW50ZXJydXB0KCkgcmln
aHQgYWZ0ZXIKaW50ZXJydXB0cyBoYXZlIGJlZW4gZW5hYmxlZCBhbmQgYmVmb3JlIHRoZSB0ZXN0
IGlzIGV4ZWN1dGVkLgoKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KVGVzdGVkLWJ5OiBNaWNoYWVsIE5pZXfDtmhuZXIgPGxpbnV4QG1uaWV3
b2VobmVyLmRlPgpSZXZpZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9y
Zz4KLS0tCiBkcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jIHwgNSArKysrKwogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCmluZGV4IDk0
YTJiZmIyNDRiMy4uNjAyY2E0YmI4ZTJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3Rw
bV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMKQEAgLTc4
OSwxMCArNzg5LDE1IEBAIHN0YXRpYyB2b2lkIHRwbV90aXNfZ2VuX2ludGVycnVwdChzdHJ1Y3Qg
dHBtX2NoaXAgKmNoaXApCiAJY2FwX3QgY2FwOwogCWludCByZXQ7CiAKKwljaGlwLT5mbGFncyB8
PSBUUE1fQ0hJUF9GTEFHX0lSUTsKKwogCWlmIChjaGlwLT5mbGFncyAmIFRQTV9DSElQX0ZMQUdf
VFBNMikKIAkJcmV0ID0gdHBtMl9nZXRfdHBtX3B0KGNoaXAsIDB4MTAwLCAmY2FwMiwgZGVzYyk7
CiAJZWxzZQogCQlyZXQgPSB0cG0xX2dldGNhcChjaGlwLCBUUE1fQ0FQX1BST1BfVElTX1RJTUVP
VVQsICZjYXAsIGRlc2MsIDApOworCisJaWYgKHJldCkKKwkJY2hpcC0+ZmxhZ3MgJj0gflRQTV9D
SElQX0ZMQUdfSVJROwogfQogCiAvKiBSZWdpc3RlciB0aGUgSVJRIGFuZCBpc3N1ZSBhIGNvbW1h
bmQgdGhhdCB3aWxsIGNhdXNlIGFuIGludGVycnVwdC4gSWYgYW4KLS0gCjIuMzYuMQoK
