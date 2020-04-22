Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2D1B4AC0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDVQnY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 12:43:24 -0400
Received: from namei.org ([65.99.196.166]:52006 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgDVQnY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 12:43:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 03MGgnwT012761;
        Wed, 22 Apr 2020 16:42:49 GMT
Date:   Thu, 23 Apr 2020 02:42:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     deven.desai@linux.microsoft.com
cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        "Serge E. Hallyn" <serge@hallyn.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH v3 05/12] fs: add security blob and hooks for
 block_device
In-Reply-To: <20200415162550.2324-6-deven.desai@linux.microsoft.com>
Message-ID: <alpine.LRH.2.21.2004230234420.12318@namei.org>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com> <20200415162550.2324-6-deven.desai@linux.microsoft.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 15 Apr 2020, deven.desai@linux.microsoft.com wrote:

> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Add a security blob and associated allocation, deallocation and set hooks
> for a block_device structure.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>

Is there any feedback from block or LSM folk on the addition of a security 
blob for block_device here?

IPE uses this is to track the status of integrity verification of e.g. 
DM-Verity devices, per this code from a subsequent patch:


+       ret = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
+                                       DM_VERITY_SIGNATURE_SEC_NAME,
+                                       v->sig->sig, v->sig->sig_size);


-- 
James Morris
<jmorris@namei.org>

