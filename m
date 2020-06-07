Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854011F0A2B
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Jun 2020 07:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgFGFgY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jun 2020 01:36:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFGFgY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jun 2020 01:36:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94BBF20B717B;
        Sat,  6 Jun 2020 22:36:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94BBF20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591508183;
        bh=ss06vkolltGcsb+CmE+gU+gjGvHgBrq6D4kImx7/V2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jI3sZR97O6Sn0VzZc/6H8WAz7ra57JGyCI2usGbb2fE1bsODOQzMPHR6JLVIIr0NP
         9Le37ho9CD/88RXR2v5ACLj4WiLiQMRi543MV8sMphvMei07nyZTli2IhWIboczg51
         csUpo26FYSldmUcb9La+e9CHdrh7QIu78GvUh8mk=
Subject: Re: result logged in integrity audit message
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com
References: <4c41ce1e-3f97-5b14-8152-5411a3debb57@linux.microsoft.com>
 <1591494710.4615.49.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d576452d-d894-aa14-be5d-4327c5d7cd53@linux.microsoft.com>
Date:   Sat, 6 Jun 2020 22:36:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591494710.4615.49.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/6/20 6:51 PM, Mimi Zohar wrote:

> Hi Lakshmi,
> 
> The commit message provides an explanation.  Look at b0d5de4d5880 ("IMA: fix
> audit res field to indicate 1 for success and 0 for failure").

Thanks for the info Mimi.

If this function logs the "result" parameter as passed by the caller, 
the audit message could be very helpful when triaging failures.
But I guess changing this now would cause regression in components that 
expect only 0 or 1 in the "res" field in an audit message.

thanks,
  -lakshmi
