Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A76B6128
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCKVtF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCKVtD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 16:49:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE534C08;
        Sat, 11 Mar 2023 13:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE48B80A4B;
        Sat, 11 Mar 2023 21:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B14C433D2;
        Sat, 11 Mar 2023 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678571339;
        bh=n3JRQcAMcYwEy8CS4/5si/5YrxyBg0r1UZbAZ2pyPlo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uyFYUKfsQB66OxBWPeAE1dkiI8u+Pc/vQpGBuYwntSNOIoK1CFbmWO5tM1LbxEk6j
         9Al9x7ycDOi9JKUpRy1bLUJp7GwlOA4+p9yCStXyeBo2W1d2P5S/ntmG4ZuxF+9EW+
         gWC4o7rbfvzh/FP5xkiktWmZ8c5/0woh4Ea5SgZ4JuQ/KYFglLrG187SyNDhPyCPm3
         /QA8p9TpthagbHhx1FQw/2RXEPxNvSlsNAeX4+1/nHUa7jyYZlwct43roUeoRyzcur
         wJ5E+ISf/KJjRuUKA5T7gBqOoiIjHtjywjxcveL2KuoPWGvz02q5rZ9vNPCm1Z6rfb
         vqVancc5B731g==
Message-ID: <01959c869e01075705cd436afa822f2586d0509c.camel@kernel.org>
Subject: Re: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
Date:   Sat, 11 Mar 2023 23:48:57 +0200
In-Reply-To: <20230302041804.24718-3-kyarlagadda@nvidia.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
         <20230302041804.24718-3-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDA5OjQ4ICswNTMwLCBLcmlzaG5hIFlhcmxhZ2FkZGEgd3Jv
dGU6Cj4gK2ludCB0cG1fdGlzX3NwaV90cmFuc2ZlcihzdHJ1Y3QgdHBtX3Rpc19kYXRhICpkYXRh
LCB1MzIgYWRkciwgdTE2Cj4gbGVuLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHU4ICppbiwgY29uc3QgdTggKm91dCkKPiArewo+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCB0cG1fdGlzX3NwaV9waHkgKnBoeSA9IHRvX3RwbV90aXNfc3BpX3BoeShkYXRh
KTsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIgPSBwaHktPnNw
aV9kZXZpY2UtPmNvbnRyb2xsZXI7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKg
wqDCoMKgICogVFBNIGZsb3cgY29udHJvbCBvdmVyIFNQSSByZXF1aXJlcyBmdWxsIGR1cGxleCBz
dXBwb3J0Lgo+ICvCoMKgwqDCoMKgwqDCoCAqIFNlbmQgZW50aXJlIG1lc3NhZ2UgdG8gYSBoYWxm
IGR1cGxleCBjb250cm9sbGVyIHRvIGhhbmRsZQo+ICvCoMKgwqDCoMKgwqDCoCAqIHdhaXQgcG9s
bGluZyBpbiBjb250cm9sbGVyLgo+ICvCoMKgwqDCoMKgwqDCoCAqIFNldCBUUE0gSFcgZmxvdyBj
b250cm9sIGZsYWcuLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmIChj
dGxyLT5mbGFncyAmIFNQSV9DT05UUk9MTEVSX0hBTEZfRFVQTEVYKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHBtX3Rpc19zcGlfaHdfZmxvd190cmFuc2ZlcihkYXRh
LCBhZGRyLCBsZW4sCj4gaW4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgb3V0KTsKPiArwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiB0cG1fdGlzX3NwaV9zd19mbG93X3RyYW5zZmVyKGRhdGEsIGFk
ZHIsIGxlbiwKPiBpbiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBvdXQpOwo+ICt9Cj4gKwoKQmFzZWQgb24gdGhlIGNvbmRpdGlvbiwgYmV0dGVyIG5hbWVz
IHdvdWxkIGJlCgoxLiB0cG1fdGlzX3NwaV90cmFuc2Zlcl9oYWxmKCkKMi4gdHBtX3Rpc19zcGlf
dHJhbnNmZXJfZnVsbCgpCgpCUiwgSmFya2tvCg==

