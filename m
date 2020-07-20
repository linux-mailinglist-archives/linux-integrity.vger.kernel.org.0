Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C462255BE
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 04:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGTCE6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 22:04:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgGTCE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 22:04:58 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50DB320B4909;
        Sun, 19 Jul 2020 19:04:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50DB320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595210697;
        bh=zRG1ESiLAHDyNiv0B4tmWGwGfmW3Odsif5Z4IcufgBY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K+4absWZa2gX4t8pSglBLKmy/9E9YldShr3PWP/443G4ykMhPoClGFe6LPQLlAz1Z
         7wtteeoDMdm3MhE7YxZUJYW7Vpbnhg56YIBwY3+Url2otVTqvZ8qZUC5zIGh91QDZU
         zNFBIl6ZDaZDBnk4jkUi8AycwnLUjaJgGD3xypcE=
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security
 state
To:     kernel test robot <lkp@intel.com>, zohar@linux.ibm.com,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     kbuild-all@lists.01.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717222819.26198-5-nramas@linux.microsoft.com>
 <202007181027.UwJXCNXk%lkp@intel.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <61a4c849-5cb7-0a58-2bb9-61f55a98657a@linux.microsoft.com>
Date:   Sun, 19 Jul 2020 19:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007181027.UwJXCNXk%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/17/20 8:14 PM, kernel test robot wrote:
> Hi Lakshmi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on integrity/next-integrity]
> [cannot apply to pcmoore-selinux/next security/next-testing linus/master v5.8-rc5 next-20200717]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]

Thank you for catching this.

I did not see these failures with the compiler and make options I'd used.

Am able to reproduce the errors with the instructions you'd provided.
Will post the updated patches shortly.

thanks,
  -lakshmi

