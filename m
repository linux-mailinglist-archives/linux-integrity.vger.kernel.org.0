Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6496D221DFB
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGPIPE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 04:15:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgGPIPD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 04:15:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 550B2B5F3;
        Thu, 16 Jul 2020 08:15:06 +0000 (UTC)
Date:   Thu, 16 Jul 2020 10:15:01 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 1/3 v1] ima-evm-utils: address new compiler complaints
Message-ID: <20200716081501.GB18117@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
 <1594864594.12900.359.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594864594.12900.359.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Address the new compiler complaints:
> - while reading the template data
> - while reading the exported TPM 1.2 PCRs
> - while reading the TPM event log

> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v1:

> - Fix fread() tests
Again, thanks for fixing this.

Kind regards,
Petr
