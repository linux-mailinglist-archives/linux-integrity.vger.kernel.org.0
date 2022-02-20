Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09F4BD2AF
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiBTXZc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:25:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiBTXZc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:25:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092233E90;
        Sun, 20 Feb 2022 15:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD65B80E0D;
        Sun, 20 Feb 2022 23:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7748FC340E8;
        Sun, 20 Feb 2022 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645399508;
        bh=3NPk12VA9hoCV4XwbL4mOQd55OrqsPyPAInVA+wQEbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRsTY9YMSnYcLPaw+k0PyY2zZSinrS2DhQS6ZLiTN6hm0uF7Ku4a1Kr3jPaGM6wiB
         FSRbueIKaIJt4lDFgLmVxEqxBox6HZBiGqZeLmMQ+1v4dm5/W49T5M9fBYhqluogTT
         Y6hsNcx96+C2kThzeVkZKMJRoFhRENPKvNufjJr+wlC0eI5m6OkyaYTFzayjxPD714
         nQK015cRs6mWpWs3A42hviJoB2AAV+WbyW6hQWWzMwYAuZVTXTTujtH/hzaGNoQ1U+
         n+2rP1HCsvF7PWOI5bPpZzuPj1TaLPc4fwT5LEaCo0ut8aS2igLEzR3aK3WG7juJFd
         drtnUORCfPjZQ==
Date:   Mon, 21 Feb 2022 00:25:46 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <YhLN+uYdEjrLyRpM@iki.fi>
References: <20220202065906.2598366-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202065906.2598366-1-vt@altlinux.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 02, 2022 at 09:59:06AM +0300, Vitaly Chikunov wrote:
> Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> does not pass in/out sizes check in keyctl_pkey_params_get_2.
> This in turn because these values cannot be distinguished by a single
> `max_size' callback return value.
> Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> algorithms.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Please provide a fixes tag and describe your changes.

BR, Jarkko
