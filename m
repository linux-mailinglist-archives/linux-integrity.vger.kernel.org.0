Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581003234F9
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhBXBKC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:10:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234630AbhBXAT1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 19:19:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 352AEAEBE;
        Wed, 24 Feb 2021 00:18:36 +0000 (UTC)
Date:   Wed, 24 Feb 2021 01:18:34 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IMA: support for duplicate measurement records
Message-ID: <YDWbWimf+tO5YvAc@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210219010045.5509-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219010045.5509-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

> Change Log v3:
>  - Incorporated feedback from Mimi on v2.
>  - Updated patch title and description to make it generic.
>  - Changed config description word 'data' to 'records'.
>  - Tested use cases for boot param "ima_policy=tcb".

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
