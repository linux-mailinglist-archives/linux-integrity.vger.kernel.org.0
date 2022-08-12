Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEA5914A1
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Aug 2022 19:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiHLRKV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Aug 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiHLRKU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Aug 2022 13:10:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F09DEFF;
        Fri, 12 Aug 2022 10:10:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 458965D92B;
        Fri, 12 Aug 2022 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660324217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZjtB7m6BM8AVhGJqivBSe/7V5icuzmK/CCVIama6jM=;
        b=a7EnxMAWHDQ7qxPyrbYQ5fcbQMBTp2uWL0w2+8GQKwLJzELA/gM4X8VIWmlQRSkY4OG5Yi
        pqeAMyEiq/tTq4ZJqJ+KxyCh9/+RQI9PCBIw+Aedr6JaGjK5oSMcb5di3bIVAnJJBeBC4a
        ofe/FDsDHQpdjMnJ2qztwgZYre8fYU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660324217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZjtB7m6BM8AVhGJqivBSe/7V5icuzmK/CCVIama6jM=;
        b=FKbQeBcNh1ssOnHGq/YFnDeFNTrgMI7ojeVuiOdvXg32EfSn8MN3RO8eVvHyVdy3dYSm7u
        lAuDs4f+3HMR4GAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37B0C13AAE;
        Fri, 12 Aug 2022 17:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YMGNDXmJ9mIOCAAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 12 Aug 2022 17:10:17 +0000
Date:   Fri, 12 Aug 2022 19:10:11 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jonathan McDowell <noodles@fb.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] x86/kexec: Carry forward IMA measurement log on
 kexec
Message-ID: <YvaJc7bQjz61Y1jj@zn.tnic>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220812164305.2056641-4-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 12, 2022 at 12:43:02PM -0400, Stefan Berger wrote:
> From: Jonathan McDowell <noodles@fb.com>
> 
> On kexec file load, the Integrity Measurement Architecture (IMA)
> subsystem may verify the IMA signature of the kernel and initramfs, and
> measure it. The command line parameters passed to the kernel in the
> kexec call may also be measured by IMA.
> 
> A remote attestation service can verify a TPM quote based on the TPM
> event log, the IMA measurement list and the TPM PCR data. This can
> be achieved only if the IMA measurement log is carried over from the
> current kernel to the next kernel across the kexec call.
> 
> PowerPC and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> # IMA function definitions
> Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG

Is there any particular reason to keep sending a patch which is already
upstream?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
