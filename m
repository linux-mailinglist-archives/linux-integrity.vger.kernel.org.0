Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8890EEAC5E
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJaJKp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 05:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJaJKp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 05:10:45 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4530420862;
        Thu, 31 Oct 2019 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572513045;
        bh=A1TNL/R7BlC3QU3qiKk6Ab/C0PvvpHBMrLered6Ickc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmdWOYTM7xT69SQn+rWSz2X9ceFDyZDsyaCYampZIqIR3tyR+htLAR3ReXIPjp81z
         Pbq/aqYEc9MY/DOx59hli0lCCO1iwb09PM+8gGWO+3BFTXC5nYw03k8BVs7NeYy6VG
         M49Jc48cbs0NarJiDJILn5ieFV4BRZO4iQ558npI=
Date:   Thu, 31 Oct 2019 05:10:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
Message-ID: <20191031091041.GO1554@sasha-vm>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031011910.2574-2-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 30, 2019 at 06:19:02PM -0700, Lakshmi Ramasubramanian wrote:
>Asymmetric keys used for verifying file signatures or certificates
>are currently not included in the IMA measurement list.
>
>This patch defines a new IMA hook namely ima_post_key_create_or_update()
>to measure asymmetric keys.
>
>Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

What are the prerequisites for this patch?

-- 
Thanks,
Sasha
