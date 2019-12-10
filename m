Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D5119F65
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 00:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLJX3v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 18:29:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45624 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJX3u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 18:29:50 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0C79220B7187;
        Tue, 10 Dec 2019 15:29:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C79220B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576020590;
        bh=uiXPuT0rz2rgnowjJOtq0WuS1BUhAKkOvqVAB3hq80I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FAnvBDGqJtl/KP+Q5YTm0V5K695Z/eElzTGO7BBM6Z5oVmY7JOkq/HxCLuBKKVIV/
         7tCrmIABR60nfB6q3JaL+40Gpnwp7dxlyoLdpijZaoCvQF42Uq4oolENM33VA1JHz1
         XiLI9RmlO80y+If+lPRvCkWYyI/mDmvTqhSmWM/I=
Subject: Re: [PATCH v10 1/6] IMA: Check IMA policy flag
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
 <20191204224131.3384-2-nramas@linux.microsoft.com>
 <1576017749.4579.40.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6385347a-bc40-7717-f9ad-8ed7dd7fee51@linux.microsoft.com>
Date:   Tue, 10 Dec 2019 15:29:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576017749.4579.40.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/10/19 2:42 PM, Mimi Zohar wrote:

> Patch descriptions aren't suppose to be written as pseudo code.  Start
> with the current status and problem description.
> 
> For example, "process_buffer_measurement() may be called prior to IMA being initialized, which would result in a kernel panic.  This patch ..."
> 
> Mimi

I'll update the patch description in this one and in the other patches 
per your comments.

Are you done reviewing all the patches in this set?

Other than the one code change per your comment on "[PATCH v10 5/6]" 
there are no other code changes I need to make?
Just wanted to confirm.

	[PATCH v10 5/6] IMA: Add support to limit measuring keys
=> With the additional "uid" support this isn't necessarily true any
more.

thanks,
  -lakshmi
