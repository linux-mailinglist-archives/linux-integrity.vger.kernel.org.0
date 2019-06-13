Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828C244BF9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfFMTRY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 15:17:24 -0400
Received: from namei.org ([65.99.196.166]:39008 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTRY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 15:17:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5DJGx5W022889;
        Thu, 13 Jun 2019 19:16:59 GMT
Date:   Fri, 14 Jun 2019 05:16:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Prakhar Srivastava <prsriva02@gmail.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, vgoyal@redhat.com
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline
 args
In-Reply-To: <20190612221549.28399-4-prsriva02@gmail.com>
Message-ID: <alpine.LRH.2.21.1906140516470.14107@namei.org>
References: <20190612221549.28399-1-prsriva02@gmail.com> <20190612221549.28399-4-prsriva02@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 12 Jun 2019, Prakhar Srivastava wrote:

> During soft reboot(kexec_file_load) boot cmdline args
> are not measured.Thus the new kernel on load boots with
> an assumption of cold reboot.
> 
> This patch makes a call to the ima hook ima_kexec_cmdline,
> added in "Define a new IMA hook to measure the boot command
> line arguments"
> to measure the boot cmdline args into the ima log.
> 
> - call ima_kexec_cmdline from kexec_file_load.
> - move the call ima_add_kexec_buffer after the cmdline
> args have been measured.
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

