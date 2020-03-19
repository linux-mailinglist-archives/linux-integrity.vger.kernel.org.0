Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3990B18BAD1
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 16:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCSPSp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 11:18:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58986 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgCSPSp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 11:18:45 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 253B120B9C02;
        Thu, 19 Mar 2020 08:18:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 253B120B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584631124;
        bh=QXbCMqJK3blmQhRaOihhXcPebuZQScHW8X262FYOfe4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=M38nE3ZtoKkWUdj6nB2QT5AP2l2c4BQB4AeL9vyDG0U/YQ4IOnM8K5cCrPMtfsm9V
         CIKkufjykyhyabrgAX/fX9rMF2+M7imNNdGIZvxPRVMDNuBPfxWXCDJkpp7nElNAsR
         mrugHpwEMM3o6/P1an2mNrhnxyVtdcSfWM/BBlAg=
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
Date:   Thu, 19 Mar 2020 08:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20190817233348.22349-1-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/19 4:33 PM, Vitaly Chikunov wrote:

Hi Vitaly,

I assume this is the latest version of your patch set. I applied the 
patch. Am seeing the errors given below.

Also, are there any other changes in for ima-evm-utils (besides the 
files listed below)?

Please let me know if I am missing something.

>   .gitignore             |   2 +-
>   Makefile.am            |   2 +-
>   configure.ac           |   1 +
>   tests/.gitignore       |  16 +++
>   tests/Makefile.am      |  12 ++
>   tests/functions.sh     | 272 ++++++++++++++++++++++++++++++++++++
>   tests/gen-keys.sh      |  97 +++++++++++++
>   tests/ima_hash.test    |  80 +++++++++++
>   tests/sign_verify.test | 366 +++++++++++++++++++++++++++++++++++++++++++++++++
>   9 files changed, 846 insertions(+), 2 deletions(-)
>   create mode 100644 tests/.gitignore
>   create mode 100644 tests/Makefile.am
>   create mode 100755 tests/functions.sh
>   create mode 100755 tests/gen-keys.sh
>   create mode 100755 tests/ima_hash.test
>   create mode 100755 tests/sign_verify.test

~/ima-evm-utils/$ ./configure
config.status: error: cannot find input file: `tests/Makefile.in'

~/ima-evm-utils/$ make

Making all in tests
make[2]: Entering directory '~/ima-evm-utils/tests'
make[2]: *** No rule to make target 'all'.  Stop.

thanks,
  -lakshmi
