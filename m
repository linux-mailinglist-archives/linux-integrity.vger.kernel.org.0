Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24D1FFABB
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgFRSF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:05:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49410 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgFRSF1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:05:27 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C614F20B4781;
        Thu, 18 Jun 2020 11:05:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C614F20B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592503527;
        bh=sL6hcuThhVlHuBMI1R5XXlVfp3rl8Nu7Pmmyg2na388=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iAm4hbN2nhtIGzZ5XO3MZc/TQ4Uy595TOYLca61C28dJBLuikMuWEbsF3kdqgVH6o
         JIpd5S5cPLiGdO8EQiNgoKQlOwGRH0CshPfdyrvc57dJ8hunRPIBaNhE8vdaT8o6v6
         LGaiFOKsn8mTPE7rnd9lspXZxBVgZfCHcO/ZGIHA=
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        nayna@linux.ibm.com, sgrubb@redhat.com, paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <20200617204436.2226-1-nramas@linux.microsoft.com>
 <20200617204436.2226-2-nramas@linux.microsoft.com>
 <1592502095.4615.42.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8b3c99b9-6691-5ae2-a287-a22a2c801c59@linux.microsoft.com>
Date:   Thu, 18 Jun 2020 11:05:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592502095.4615.42.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/18/20 10:41 AM, Mimi Zohar wrote:

> 
> For the reasons that I mentioned previously, unless others are willing
> to add their Reviewed-by tag not for the audit aspect in particular,
> but IMA itself, I'm not comfortable making this change all at once.
> 
> Previously I suggested making the existing integrity_audit_msg() a
> wrapper for a new function with errno.  Steve said, "We normally do
> not like to have fields that swing in and out ...", but said setting
> errno to 0 is fine.  The original integrity_audit_msg() function would
> call the new function with errno set to 0.

If the original integrity_audit_msg() always calls the new function with 
errno set to 0, there would be audit messages where "res" field is set 
to "0" (fail) because "result" was non-zero, but errno set to "0" 
(success). Wouldn't this be confusing?

In PATCH 1/2 I've made changes to make the "result" parameter to 
integrity_audit_msg() consistent - i.e., it is always an error code (0 
for success and a negative value for error). Would that address your 
concerns?

thanks,
  -lakshmi




