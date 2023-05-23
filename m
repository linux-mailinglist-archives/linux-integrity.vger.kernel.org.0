Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB670E8A2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 00:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjEWWKX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjEWWKW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 18:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92D83
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 15:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 513D0636E6
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 22:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8209C433EF;
        Tue, 23 May 2023 22:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684879820;
        bh=GWOgD+9zMvd+o4oZ4d7pTfmYAxJqAHyJjsRSNY2Fcxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5axkveTe1cpxiiny429JHYMhZFUTT68I8P8N7O553+7MhMIn1KL1hrTZHvs74pnc
         QeDsOkAEC5uurFpmE54kKVC+M0/kYcslq9r8nAAA2WJxKKPlSVSv433xK4lDw98+kY
         frOFCwN4by2dSE1VIs87QrsoT/dToWFLw/vQFETxPM4RpfZoEde5mvQ2y0e07lO9Mn
         EV7gPojfjVZGSbR7+k9t8i4i23yF3uCvoXAedkFqVaIWqaqMfykbdhEtidxr6PeXn0
         23DOczgVYVTyUcZHoTRk6V1zFOSjClPmQowa1nzBojnf8EvyYVxMRBmz7bfx3c3K6c
         kBDbvxpSldqwA==
Date:   Tue, 23 May 2023 22:10:19 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Linux Integrity <linux-integrity@vger.kernel.org>
Subject: Re: hash_info.h appreviations
Message-ID: <20230523221019.GB888341@google.com>
References: <4c4dae24-d367-699b-130b-4ac5b69c4597@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4dae24-d367-699b-130b-4ac5b69c4597@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 05:58:25PM -0400, Ken Goldman wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/hash_info.h
> 
> I'm writing IMA documentation.  These enums appear in the IMA event log.
> 
> I suspect that WP is Whirlpool and TGR is Tiger?
> 
> Can you confirm?

Yes that's correct.

However, note that Tiger support was removed from the kernel source tree by the
following commit:

    commit 87cd723f8978c59bc4e28593da45d09ebf5d92a2
    Author: Ard Biesheuvel <ardb@kernel.org>
    Date:   Thu Jan 21 14:07:32 2021 +0100

        crypto: tgr192 - remove Tiger 128/160/192 hash algorithms
