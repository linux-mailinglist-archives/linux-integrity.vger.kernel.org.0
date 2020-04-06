Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133C819FD46
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFSgU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 14:36:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37184 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSgU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 14:36:20 -0400
Received: by linux.microsoft.com (Postfix, from userid 1033)
        id 51D582072933; Mon,  6 Apr 2020 11:36:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51D582072933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586198179;
        bh=OEudVpLjqf3g5HvN9ndvJvlBTCIbEu5ziBVGQiVKHgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjOaUnzZEyI7GxQRyFYX8vUHitCF4H6PoK7lk1pRlv++G6IrJNeTmOhb5EmVTDcpn
         n4FZscaj5ktDqCf4NumeUWpz8LTOqGZ+AsgyYH9Oa+oNGv29ryXsRcZJ86GfLisr1p
         aA1qDBBjfw5eGwWYF/LZ9c8SGFA/0qtV/TqlO1/U=
Date:   Mon, 6 Apr 2020 11:36:19 -0700
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



This was resent due to an incorrect domain for dm-devel (redhat.org vs redhat.com), and an email address
that was bouncing.

Additionally, this is an RFC, and this tag will be added in the next iteration.

- Deven
