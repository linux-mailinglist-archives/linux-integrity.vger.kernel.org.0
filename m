Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6561FCB2CC
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfJDAjF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 20:39:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35368 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfJDAjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 20:39:04 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 238AF20110DD;
        Thu,  3 Oct 2019 17:39:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 238AF20110DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570149544;
        bh=xSLsUni3aslE1aApC6oyO4ubvW9lDKc1MyIzPKb9IcI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FqpJhuy/Z+zIJvb7AuKCtEe5+wKQ630DYTiui58Vj77yZBdyowClUmS98n5mMKh7R
         Szy9WQyq+numOung8tYqrCOJcRD1OjFxa1GOxf3r2k9xCfcdHJyrlbrDJGVTvZbnKI
         ozO31HUf+YN681qE1yMwf0FplT7gGLpS3dc8zxFA=
Subject: Re: ima_tpm_chip is queried and saved only at IMA init, but never
 later
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
References: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
 <1569364624.5364.23.camel@HansenPartnership.com>
 <d5aef823-9428-65d4-c045-c23d3466033e@linux.microsoft.com>
 <1570117759.5046.4.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <570885b3-c595-7381-3c03-91282d82351e@linux.microsoft.com>
Date:   Thu, 3 Oct 2019 17:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570117759.5046.4.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/3/19 8:49 AM, Mimi Zohar wrote:
>> Can IMA take a dependency on TPM and postpone IMA initialization until a
>> TPM device shows up?
> 
> IMA is already on the late_initcall(), waiting for the TPM
> initialization to complete.  

> How would you define a TPM dependency?
I meant - can IMA return a status code from it's init routine such that 
it gets called back when a TPM device shows up. And, at that point 
continue the initialization.

Similar to how a driver for Device A would indicate it's dependency on 
the availability of a Device B. I am not sure if such a thing is 
possible with IMA.

Thanks,
  -lakshmi

