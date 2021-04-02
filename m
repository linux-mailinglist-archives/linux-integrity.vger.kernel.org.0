Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08069352444
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Apr 2021 02:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhDBAMh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 20:12:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35844 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDBAMg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 20:12:36 -0400
Received: from [10.0.0.133] (unknown [24.16.66.129])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4133E20B5680;
        Thu,  1 Apr 2021 17:12:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4133E20B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617322356;
        bh=lE1QMI42+BaWVRs7KfDdCa5SdJlcDwqRYnq5+sEkiJo=;
        h=To:Cc:From:Subject:Date:From;
        b=Id8tzrmNbPw6RKVQiK1y+5wkTKfj5j9ns2VTVH/Rkg3VJXt682NdAogUwRD1WNNK2
         bbUebVNuJYI/anLqxq9Nk9L7ImTHiGX/FwMAa7hA5oApEncPPfpYO396fX/wKRDXzm
         guDOyA1EXVACG84eIbZtDIil/j2spaRFSb/YKC7M=
To:     pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org
From:   Fan Wu <wufan@linux.microsoft.com>
Subject: Question about the available tests for IMA apprise
Message-ID: <cb6ed68b-3f4a-2a4e-9010-0e385af5b7d4@linux.microsoft.com>
Date:   Thu, 1 Apr 2021 17:12:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

We are trying to extend the IMA apprise action. To prevent breaking the 
system, we want to collect existing apprise-related tests, but I find 
there are not many tests related in the LTP project.

As far as I am aware, only evm_overlay and kexec tests are testing with 
a policy that contains a apprise rule. But they do not test the file 
execution (exec/mmap/mproject syscalls with various args) we are 
focusing on.

I am wondering, are all available tests in the LTP? Also, I am looking 
for suggestions for testing apprise.

Thanks.

Fan
