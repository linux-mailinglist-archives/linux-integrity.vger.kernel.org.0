Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142EBE5028
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJYPbw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 11:31:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56382 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbfJYPbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 11:31:52 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4FBAA20F3BFE;
        Fri, 25 Oct 2019 08:31:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FBAA20F3BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572017511;
        bh=6nupwpvuElnWECyNPkwMWvzvjiUYorzVVuiNAsZs9CM=;
        h=To:Cc:From:Subject:Date:From;
        b=YxCDnyrzdUQIBfR597vOW+0wCwSt3rhaU4z3GHy/YikMhLvxgM8LZS0A/Bk/4GtMZ
         ZIDcSHby67ZupNRwgPXpOvZZY5bSOTjL7p4VGRZxiYK0HOKA/ghSJLzXS5xidjQvI/
         wc1bcVwp8MBriyRVNiem6Ry1gZQO+WDOZrwkztzE=
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        prsriva@linux.microsoft.com
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Tests to run to validate ima related changes
Message-ID: <95a38379-eb58-011a-4886-035fa9785c68@linux.microsoft.com>
Date:   Fri, 25 Oct 2019 08:32:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Is there a set of tests that we can run to validate ima related changes? 
I can run those to verify that the code changes we make.

As Prakhar had asked in another email - we can add\update tests as 
appropriate for the changes we are making.

Please share any documentation and process for the tests.

thanks,
  -lakshmi
