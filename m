Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F07564BC9
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jul 2022 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGDCg2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 Jul 2022 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDCg1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Jul 2022 22:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E4546560
        for <linux-integrity@vger.kernel.org>; Sun,  3 Jul 2022 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656902186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1FJ6cqRuF8dBXv9KcZczCA6imIHUu41nOlrwT+WJ0s=;
        b=DumGiiXWuHxiJcxBICHtVo03K4sSvRrpuyOriDgaCVT32x/EMopRbGwa0tfEG0l2CbVzoY
        ktOCNzIXFoHstInzQcCKde8RORhTuzuLahbl2BuTdMJfariG1Afe58zvMfdzCUhx2m+/ZS
        SAVvv0j4U1XJNvR3uQ1DMfYpL9+LrCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-FYcXjujqMAeLRZl34AbSJQ-1; Sun, 03 Jul 2022 22:36:22 -0400
X-MC-Unique: FYcXjujqMAeLRZl34AbSJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3B485A581;
        Mon,  4 Jul 2022 02:36:22 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5646C1415308;
        Mon,  4 Jul 2022 02:36:19 +0000 (UTC)
Date:   Mon, 4 Jul 2022 10:36:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v7] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <YsJSIIsCnjoL+ObY@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
 <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
 <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06/30/22 at 08:36am, Jonathan McDowell wrote:
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
> (Mimi, Baoquan, I haven't included your reviewed-bys because this has
>  changed the section annotations to __init and Boris reasonably enough
>  wants to make sure IMA folk are happy before taking this update.)
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

