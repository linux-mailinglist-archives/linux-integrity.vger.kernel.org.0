Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B6109364
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2019 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKYST7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Nov 2019 13:19:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38192 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfKYST7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Nov 2019 13:19:59 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FA2F20B7185;
        Mon, 25 Nov 2019 10:19:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FA2F20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574705998;
        bh=Lsf35oJGVj/tzKzffjdbzr33uAXcLV2nG0AvSRS05OE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kafunRkZuGNCUrg7ARYuumb0QGyaCDgsaOExf1DpwOQTxrlafd3f0Knd2CNOt728c
         wlZsnlHvrbc2MDu6hjcCPZTW2cyycUhgh0LDhOA9Jf5exQ7q4Fz7fOL83niUGQcvBd
         SA436cmfFa5XYDucPrPwzSi6xFnClkxT4SMWQqSI=
Subject: Re: IMA: Data included in the key measurement
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
 <1574354333.3277.27.camel@HansenPartnership.com>
 <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
 <1574439451.3331.14.camel@HansenPartnership.com>
 <6ceecb10-61f5-1067-d219-1f6caaa104a9@linux.microsoft.com>
 <1574705677.4793.215.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c220c857-5473-914c-b7af-b05fce6c0fc0@linux.microsoft.com>
Date:   Mon, 25 Nov 2019 10:19:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574705677.4793.215.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/25/19 10:14 AM, Mimi Zohar wrote:

> 
> Only the commands to validate the "key" measurement and extract the
> certificate need to be included in the patch description.  You could
> combine these two commands using "tee".  One would save the
> certificate, while the other would calculate the template data hash.
>   Providing the openssl command to display the saved certificate is
> optional.
> 
> Mimi
> 

Sure - I just wanted to provide more details in this mail to get 
feedback\comments on the measurement data included.

Will include only the info you've listed above when I send the patches.

thanks,
  -lakshmi

