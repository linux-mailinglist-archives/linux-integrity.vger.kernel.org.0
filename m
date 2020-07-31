Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E2234D04
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgGaVbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 17:31:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41538 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGaVbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 17:31:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4A3CB20B4908;
        Fri, 31 Jul 2020 14:31:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A3CB20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596231084;
        bh=S4cTyhHoE+e/ZUW8inxxRdk7qNFQf+4rRLYkoIY0bi0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XWFKsrXff+XTGjLVr0uyHzTS4nxNB+vGdgDR0Le89hWAKGSMsXDUzUyeeakkeA0WE
         3gFxaJtt6+MrdgBMhwAgHdGk5VTCa8eGweHT8CEp/6oljeLIUEsJvMDAACH996G+aj
         lEEkjnlSEyvAuyv7J89ZJB1TUzCgXTHefgzomK8c=
Subject: Re: [PATCH] IMA: Add a test to verify importing a certificate into
 custom keyring
To:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20200717205721.18173-1-t-josne@linux.microsoft.com>
 <20200731080221.GA14041@dell5510>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <edf26ac1-6378-c632-9e91-5c09141639af@linux.microsoft.com>
Date:   Fri, 31 Jul 2020 14:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731080221.GA14041@dell5510>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/31/20 1:02 AM, Petr Vorel wrote:

Hi Petr,

>> A test for verifying importing an x509 certificate into a keyring and
>> validating the key measurement performed by IMA is needed.
> 
> I suppose you're going to send new version of this patch (rebased + fix
> according to Mimi's comments).
> 
> IMHO that should be your last not yet merged patch.
> 
> FYI: I'm planning to fix ima_tpm.sh and then implement autoloading IMA policy
> (when possible).
> 

Yes - Lachlan will send the new version of the patch set (rebased to 
your latest changes and also addressing Mimi's comments).

thanks,
  -lakshmi

