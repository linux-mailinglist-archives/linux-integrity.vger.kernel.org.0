Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861DE4DC113
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Mar 2022 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiCQI3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Mar 2022 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCQI3H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Mar 2022 04:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DA17B0C0
        for <linux-integrity@vger.kernel.org>; Thu, 17 Mar 2022 01:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49399B81DAB
        for <linux-integrity@vger.kernel.org>; Thu, 17 Mar 2022 08:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B037FC340E9;
        Thu, 17 Mar 2022 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647505668;
        bh=GlGuLfBCFkgxlBpkVP9Q9ZSr6CwIlHRIYhTr8Wf4Qh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwavbUzFAYS5e7+JXyM99ZkyJ6FoVud0ZmnIB/Wkm+stml1IqYMMRRegqe+HtEhbh
         6idr8+WS0ueGy5+Q1BEiMdxS0NzGWdBAygN9wonrM6qmteZfOm0fC54w/ZNZ3b5DPo
         hS8Bt3Le5/c2WdfhuSmXQHQfsNgWmK/6/B19MkdLyc7hLVQpEvgZIywaPS1bLV8LeQ
         QH3SEBEWJCZXOcrrmODqdf/Hi/hD8b0cx51TUPvR6xpX6w/B01H0DRjJETpEvUBQjz
         FUu/AP1k6VL9AMFvWBeBFjL/52mD/Nv0ldyr9GNv1GawI8Dcigv//VTCtqkIfJBoZR
         UymJlzLYVA6Pg==
Date:   Thu, 17 Mar 2022 10:26:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v2] tpm: Make implementation of read16/read32/write32
 optional
Message-ID: <YjLw0sCDqHxy66jo@iki.fi>
References: <20190718170355.6464-2-Alexander.Steffen@infineon.com>
 <20220315161446.534-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315161446.534-1-johannes.holland@infineon.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 15, 2022 at 05:14:46PM +0100, Johannes Holland wrote:
> From: Alexander Steffen <Alexander.Steffen@infineon.com>
> 
> Only tpm_tis and tpm_tis_synquacer have a dedicated way to access
> multiple bytes at once, every other driver will just fall back to
> read_bytes/write_bytes. Therefore, move this common code out of
> tpm_tis_spi_main and tpm_tis_spi_cr50 into tpm_tis_core, so that it is
> automatically used when low-level drivers do not implement the
> specialized methods.
> 
> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---

Please, add a change log to the next version, which also includes
description of v2 changes.

Redudancy is insignificant, and how things are now does not require
special cases from the upper layer.

Instead you should do this:

enum tpm_tis_io_mode {
        TPM_TIS_PHYS_8,
        TPM_TIS_PHYS_16,
        TPM_TIS_PHYS_32,
};

struct tpm_tis_phy_ops {
	int (*read_bytes)(struct tpm_tis_data *data, u32 addr, u16 len, u8 *result,
                          int mode);
	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len, const u8 *value,
                           int mode);
};

And e.g.

static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
{
        rc = data->phy_ops->read_bytes(data, addr, sizeof(u16), &result_le, TPM_TIS_PHYS_16);
}

This takes away over half of the callback API, and does not require special
cases on the top layer.

BR, Jarkko
