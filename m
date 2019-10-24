Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB1E3E75
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 23:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJXVpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 17:45:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60306 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfJXVpF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 17:45:05 -0400
Received: from [10.137.104.49] (unknown [131.107.147.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 470842010AC3;
        Thu, 24 Oct 2019 14:45:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 470842010AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571953505;
        bh=QTdPBz8YLPIjs5QB/X81saO1aG1r0L8T75VYgFkAwWg=;
        h=To:Cc:From:Subject:Date:From;
        b=n1vFKFadHhn8uztu7k50QlFMS7UjzVylR1npFeyP/Rk2L8C5F5Vt4poW1f0T6gyXl
         Q1u7KOs6tbBXaw16C1A1YZao1wvYzWiEUJlxjrwcljQ8kyiDvucwjLD6Z6JeBvFkAG
         M3iWZnAA0A3O3n4XEJLYkIKZUhmjpNF3bB/Qh/X4=
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
Subject: IMA test information
Message-ID: <2ad65310-cac1-2fdc-c7fd-5ac77293d622@linux.microsoft.com>
Date:   Thu, 24 Oct 2019 14:45:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I am looking towards writing some tests for the checked in
code for KEXEC_CMDLINE and some sanity test.

Can someone point me to documentation and the process
for tests?

Thanks in advance.
Prakhar Srivastava
