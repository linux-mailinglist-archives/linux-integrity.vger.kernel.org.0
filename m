Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7311BC51
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 19:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLKS6J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 13:58:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfLKS6J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 13:58:09 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F12A20B7187;
        Wed, 11 Dec 2019 10:58:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F12A20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576090688;
        bh=LIhsrCaNXEXwEwarr7cNKNbyzjJLhi8lRaX97UO0qmk=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AIcY7lvv8tBN37kxbW6ATKmwocZYMieFKWtRogzbZBX5K/Z+JP3VpClSZzwBcjRFX
         J9WCVAXKIKx2gKGru1H7byGyUwesP7SE83xZ3JRReZUmD6h1KhNyoAyRxb0DOpgzKj
         TwK5HV/gtcpM1pESCO0Myig3OWcFeozXEnyGvDbI=
Subject: Re: [PATCH v1 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
 <20191206012936.2814-2-nramas@linux.microsoft.com>
 <1576028407.4579.77.camel@linux.ibm.com>
 <1576069442.4579.131.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <39a69e6a-d5b9-f12e-7849-f6a88d7b867d@linux.microsoft.com>
Date:   Wed, 11 Dec 2019 10:58:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576069442.4579.131.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/11/19 5:04 AM, Mimi Zohar wrote:

Hi Mimi,

> Sorry, one more comment.  Appending "_for_measurement" or inserting
> "_measure_" makes these function names unnecessarily long.  This
> information can be included in the function descriptions.
> 
> Mimi

Thanks for reviewing the changes.

I have addressed your comments and posted new patch sets for the key 
measurement changes.

thanks,
  -lakshmi

