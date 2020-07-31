Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35012340BD
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgGaICY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 04:02:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731479AbgGaICY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 04:02:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E75F0ADF2;
        Fri, 31 Jul 2020 08:02:35 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:02:21 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] IMA: Add a test to verify importing a certificate into
 custom keyring
Message-ID: <20200731080221.GA14041@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200717205721.18173-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717205721.18173-1-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> A test for verifying importing an x509 certificate into a keyring and
> validating the key measurement performed by IMA is needed.

I suppose you're going to send new version of this patch (rebased + fix
according to Mimi's comments).

IMHO that should be your last not yet merged patch.

FYI: I'm planning to fix ima_tpm.sh and then implement autoloading IMA policy
(when possible).

Kind regards,
Petr
