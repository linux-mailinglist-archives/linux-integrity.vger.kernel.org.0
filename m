Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6E1E445
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 00:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENWHj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 18:07:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50982 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENWHj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 18:07:39 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA0B520110B7;
        Tue, 14 May 2019 15:07:38 -0700 (PDT)
Subject: Re: IMA signature generated by evmctl has unexpected key identifier
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <alpine.LRH.2.21.1905092048590.7180@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <90a4d769-4c32-4b2b-ceaa-6e0980d5c193@linux.microsoft.com>
 <1557854750.4139.65.camel@linux.ibm.com>
 <4b810e48-6ddc-19d0-9fc1-70cd29c7c01b@linux.microsoft.com>
 <1557869914.4139.73.camel@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <5d1ab46e-ea01-b7a7-4a9b-6e4bcb63c331@linux.microsoft.com>
Date:   Tue, 14 May 2019 15:07:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557869914.4139.73.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/14/19 2:38 PM, Mimi Zohar wrote:

 >> Keyring
 >> 1054868458 ---lswrv      0     0  keyring: .ima
 >>     740136756 --als--v      0     0   \_ asymmetric: hostname: 
whoami signing
 >> key: 85512d09fc12c7f38b9679352651dcb365903336
> 
> I should have asked you to make sure that the last 8 bytes of "X509v3
> Subject Key Identifier" in the certificate used to sign the kernel
> image is the same as above.
> 
> Mimi
> 

Yes - the Subject Key Identifier matches the output from keyctl.

Please see below:

X509v3 Subject Key Identifier:
                 85:51:2D:09:FC:12:C7:F3:8B:96:79:35:26:51:DC:B3:65:90:33:36

thanks,
  -lakshmi

