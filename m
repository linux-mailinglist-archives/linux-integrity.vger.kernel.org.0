Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0D1AD3DB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2020 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgDQAx5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 20:53:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56924 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDQAx5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 20:53:57 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B5E5320B46F0;
        Thu, 16 Apr 2020 17:53:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5E5320B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1587084837;
        bh=KyuX1Ycfzax8gZMWL41S2/d1pP4VYABr3m40XeTwWWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IJ4e3Znk3ZcG0b0X/+YmpQJKVfLR34CsKJCRcPFbWpyR0kMXhiOzLI1kiRJk9g61t
         3g6oNeIcsPgeB/RGqoNLFivPx3Zu9FSzQpR7tM/JnsuEZCzCN8WXCEQMePWuc57HVA
         +EpMg4E+ngzxcKNnp8kHdx7dcY/DSW/5fZogi6eQ=
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Stephen Smalley <stephen.smalley@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, dm-devel@redhat.com,
        James Morris <jmorris@namei.org>, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
 <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com>
 <1586826679.7311.174.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <96c53a34-315c-946d-3264-e6e2cd19f583@linux.microsoft.com>
Date:   Thu, 16 Apr 2020 17:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586826679.7311.174.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-04-13 6:11 p.m., Mimi Zohar wrote:
> On Sun, 2020-04-12 at 11:15 +0300, Lev R. Oshvang . wrote:
>> On Sat, Apr 11, 2020 at 10:07 PM Stephen Smalley
>> It sees to me that  LKRG (kernel run time guard)  takes the role of
>> measuring kernel structures.  Perhaps you need to consult with LKRG
>> guys.
> 
> There definitely sounds like there is some overlap.  LKRG seems to be
> measuring kernel structures for enforcing local integrity.  In the
> context of IMA, measurements are included in the IMA measurement list
> and used to extend a TPM PCR so that it can be quoted.
> 
> A generic method for measuring structures and including them in the
> IMA measurement list sounds interesting.
Thanks for the feedback Mimi.
We were also thinking along the same lines of generic method
for measuring structures.
We will take this feedback into account while implementing.
> 
> Mimi
> 
