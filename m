Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EECC2DE235
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 12:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgLRLqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 06:46:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:41744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgLRLqT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 06:46:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07D87AEA3;
        Fri, 18 Dec 2020 11:45:38 +0000 (UTC)
Date:   Fri, 18 Dec 2020 12:45:36 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <X9yWYJ3P/Qhlesq7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
 <aec8d4d757c674b3fdb4caaf3d89317d230b91e7.camel@linux.ibm.com>
 <X9sXxGacmaPYN8hp@pevik>
 <3df04bcb427a225de4fe7cb4886a3539b8735dbc.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df04bcb427a225de4fe7cb4886a3539b8735dbc.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > So, can I merge the patchset with your ack/review-by?

> Yes, I just finished reviewing the patches.   Other that clarifying the
> patch descriptions and fixing the one typo  ("tmp" -> "tpm"), it looks
> really.
Fixed those typos and commit message and finally merged.
Thanks a lot for your several patient reviews and suggestions!

Petr

> thanks! 

> Mimi

