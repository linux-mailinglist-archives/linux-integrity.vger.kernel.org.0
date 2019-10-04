Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFACC3F9
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfJDUKg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 16:10:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56908 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbfJDUKg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 16:10:36 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7162A20B71C6;
        Fri,  4 Oct 2019 13:10:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7162A20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570219835;
        bh=7aHTNMZx8Fdo2zYSethzSgfrfWzeHKOy2BghF517wsQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZpVdPi6fvg8UIWu1zEM43+/uZVJHaAg6QJquwnL1ZNO94nqLCpDtqjJ76itAXZGXg
         Tyvp8g0RzBKLiQR97WI+he5HfDR8/SoVOLR3qvaFdXlhFXzMKwAMf6bdrh+Nh7sHKR
         0n8QVae31yqRMzbpNT6XJD3xQDvkV/XAB/DB64UI=
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
 <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
 <1568913178.4733.89.camel@linux.ibm.com>
 <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
 <1570219032.5046.101.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
Date:   Fri, 4 Oct 2019 13:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570219032.5046.101.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/4/19 12:57 PM, Mimi Zohar wrote:

> 
> IMA is late because it is waiting for the TPM to be available.
 >
> Another option would be to queue the measurements and then replay
> them once the TPM and IMA are available.
> 
> I'm not sure I like this approach any better.

I agree - I too don't like this approach (queue the measurements and 
then replay). Even in that approach IMA will have to invoke functions 
outside of IMA to retrieve the stored measurements.

I prefer gathering data on trusted keys in ima_init, but gate it by IMA 
policy and follow the other coding guidelines you have suggested earlier 
(similar to the approach taken for kexec_cmdline measurement).

Please let me know if you agree - I can send the new patch set by next week.

Thanks,
  -lakshmi

