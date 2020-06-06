Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36AD1F045D
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jun 2020 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFFDOB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 23:14:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33698 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgFFDOA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 23:14:00 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4A97520B7185;
        Fri,  5 Jun 2020 20:14:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A97520B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591413240;
        bh=Y31Z41DsqlncijtP1cG3/HsNjUnFLOxU3PHh2sW5648=;
        h=To:Cc:From:Subject:Date:From;
        b=jyRSPsqG7nH5YeTTvHYszbNMgkadok1PC0sMmbZU62jXZ2pMzFDqApkmDh7mrCiE1
         VES2dd7jqV+uZxO+XL1IbwVwTWQDgo7BtoB2gu7saC/mgVzdszc1l0jkViLizllbli
         2Ns6OolL4FsC1rYfygUDiikNm7YbwPEZ1GPblhcU=
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: result logged in integrity audit message
Message-ID: <4c41ce1e-3f97-5b14-8152-5411a3debb57@linux.microsoft.com>
Date:   Fri, 5 Jun 2020 20:13:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

In integrity audit message function the inverse of "result" is being 
logged for "res=". Please see below. Is this intentional?

void integrity_audit_msg(int audit_msgno, struct inode *inode,
			 const unsigned char *fname, const char *op,
			 const char *cause, int result, int audit_info)
{

  ...
  audit_log_format(ab, " res=%d", !result);
}

The callers of this function are passing an error code (-ENOMEM, 
-EINVAL, etc.) in the "result" parameter. But that error code is lost - 
instead "res" is set to 0.

For example,

audit: type=1804 audit(1591411737.631:3): pid=1 uid=0 auid=4294967295 
ses=4294967295 subj=kernel op=ima_alloc_key_entry cause=ENOMEM 
comm="swapper/0" name=".builtin_trusted_keys" res=0

thanks,
  -lakshmi
