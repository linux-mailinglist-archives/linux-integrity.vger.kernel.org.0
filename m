Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1EEFE66C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Nov 2019 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOUfE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Nov 2019 15:35:04 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43760 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOUfE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Nov 2019 15:35:04 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5BD932010688;
        Fri, 15 Nov 2019 12:35:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BD932010688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573850103;
        bh=UsriIi/AR6aXXB4mccM4CzK1HsGXzB8Gu8Fw14iu8iI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PApOFFak/vFKmPamiN/zSYbG2jVi6YZDM65N+jRM0wJuGINsenwK13V9wl2tjwI87
         jXWxVDq+ZdQbYLrTD3M6JXpZR9Pp5Dy1nbP00CHfC/RDlALC/FJP6LZBZSoL+A+5En
         QauVIHK1hNEqsyGhsgRBLDw+v9nVfNLpvfSvscpY=
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
To:     Patrick Callaghan <patrickc@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
 <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
 <1573578841.17949.48.camel@linux.ibm.com>
 <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
 <1573582344.17949.67.camel@linux.ibm.com>
 <abdf66fb39d4c8ee08e0b52c34fb81b93bd33006.camel@linux.vnet.ibm.com>
 <4e1c0c6b-a5e1-a95a-8a0b-c5a7f0a253cf@linux.microsoft.com>
 <ffb1ec9d8cf12f6366fb4eb022a5442a8edae53c.camel@linux.vnet.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3bb7ee92-9a8f-d180-a1dc-5f737db5252d@linux.microsoft.com>
Date:   Fri, 15 Nov 2019 12:34:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ffb1ec9d8cf12f6366fb4eb022a5442a8edae53c.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/15/19 7:25 AM, Patrick Callaghan wrote:

> Hello Laks,
> Agreed. The assumption is that integrity_kernel_read() function does
> not return a value greater than the fourth parameter passed to it (i.e.
> does not read more bytes from the file than the size of the buffer
> passed to it). I tried to validate that this assumption was true by
> following the code but felt I could not prove it with my current
> knowledge of the code. If this assumption is not true then I believe
> that any code change for this problem should go into a different
> patch.

I agree Patrick - not a blocker for this patch set.

thanks,
  -lakshmi


