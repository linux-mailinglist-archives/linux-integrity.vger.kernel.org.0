Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6C728E6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGXHQu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 03:16:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfGXHQt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 03:16:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBA2BAD17;
        Wed, 24 Jul 2019 07:16:48 +0000 (UTC)
Date:   Wed, 24 Jul 2019 09:16:53 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190724071653.GA21085@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1563913626-28061-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563913626-28061-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> application is required to read PCRs.

> This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> tsspcrread is one application included in the ibmtss package.

> Sample error messages:
> Failed to read PCRs: (tsspcrread failed: No such file or directory)
> Failed to read PCRs: (TSS_Dev_Open: Error opening /dev/tpmrm0)

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
