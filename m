Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9110C33D57C
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhCPOHm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 10:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232611AbhCPOHO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 10:07:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8FEDABD7;
        Tue, 16 Mar 2021 14:07:12 +0000 (UTC)
Date:   Tue, 16 Mar 2021 15:07:11 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
Message-ID: <YFC7j4+wA8xorNgu@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314233646.2925-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Mimi,

> ima-buf is the default IMA template used for all buffer measurements.
> Therefore, IMA policy rule for measuring keys need not specify
> an IMA template.  But if a template is specified for key measurement
> rule then it must be only ima-buf.

> Update keys tests to not require a template to be specified for
> key measurement rule, but if a template is specified verify it is
> only ima-buf.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Just a double check does it always work without template=ima-buf for all kernel versions?
Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
i.e. v5.11-rc1 or backport?

Also, don't we want to change also keycheck.policy?
Currently it contains:
measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
Do we want to drop template=ima-buf to test the default value? Or have two rules
(one with template=ima-buf, other w/a?)

Mimi, any comment on this?

Kind regards,
Petr
