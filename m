Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018E4E1DF1
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiCTVXZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiCTVXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:23:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058F18A3E9;
        Sun, 20 Mar 2022 14:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA5DB80EFA;
        Sun, 20 Mar 2022 21:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9552CC340E9;
        Sun, 20 Mar 2022 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647811319;
        bh=VCO2HOCuTBN+Xv7u6MBQ5uA0+TGwA+QA643VoWQB4s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RH/gyeIDR4Y6vBxwoPf+bvJnNWspNNBT6gVUuJ9ByOxDzlcnQ1M4u09mnX13tV9c6
         q2FQMNR7zBKXmEBj4OcDYHkQD9+QXNGC4phBUINAh4Kq2rtvmRzsDQcAehbLm2zTFZ
         S66yZl1SlynQdT7eBHOzO79uVIDut3UFF8vGeXrmAKHLyMZIhWNHKAnCNTR/e7eFeV
         +FuwOc7ufk2jvR348NiSyo2dQrWbV3wGyizX1vilR/Hd6b8ie8XpkyYI/G23x9B6r6
         CcKnrUa1WLRAkGNRJ7MWVgFuTQxUwA6HrZYXC3XPfGlN8aWOtjje1HxTnhfYttgLgR
         IGANPRJRxzQow==
Date:   Sun, 20 Mar 2022 23:23:00 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, nayna@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] tpm: ibmvtpm: Correct the return value in
 tpm_ibmvtpm_probe()
Message-ID: <YjebNG+q9kuh56iv@kernel.org>
References: <20220318060201.50488-1-xiujianfeng@huawei.com>
 <977ccc4b-3b30-f301-aa1c-ef2aaa32cacd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977ccc4b-3b30-f301-aa1c-ef2aaa32cacd@linux.ibm.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 18, 2022 at 09:54:46AM -0400, Stefan Berger wrote:
> 
> 
> On 3/18/22 02:02, Xiu Jianfeng wrote:
> > Currently it returns zero when CRQ response timed out, it should return
> > an error code instead.
> > 
> > Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thank you, I applied this.

BR, Jarkko
