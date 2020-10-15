Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9328A28F2E3
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJONEs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 09:04:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgJONEs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 09:04:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09FD2HPs151166;
        Thu, 15 Oct 2020 09:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Editoim7y1q+HBIS/s7GtfFpmxMrMRA6CVw4hXetAvI=;
 b=iN+CkHULfY/LRVoEoaC72J8ZsCIxT37oPNM5sCSJFrH3YyBxbvZBywLL6mNic88GAMym
 k/qLRht4aa9ilC2fpGWEqcyWj3d7ZQf+tIqCMTJet1ox2zPiKikoMyNJeY6nc4wXVRuX
 uemSDor93ZBrOpoSpwK3VwLUsnKSbAv5RRc+CYUFyiw7plnPMD7Wz5wk9T8ospE6hYbn
 z+cKKhvVLauj5HVvBbjXDBXR7yJw2BtBl+hOP1v4BpNRa/9k4jvGGlmqJ8ek3fGaT7ot
 W2GKw3cOCfdXf6t5utfcZt/czTV05d3Mxx6+ka5THUXCC+55NdjnhgjK7+CWy8kA6Jjv 5w== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 346pss0g71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 09:04:45 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09FD3nte001825;
        Thu, 15 Oct 2020 13:04:42 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3434k9car5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 13:04:42 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09FD4fA948169372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 13:04:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D732112062;
        Thu, 15 Oct 2020 13:04:41 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 597B1112070;
        Thu, 15 Oct 2020 13:04:41 +0000 (GMT)
Received: from [9.80.236.207] (unknown [9.80.236.207])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Oct 2020 13:04:41 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable TPM_SERVER_TYPE
 for tpm_server
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
 <20201012234416.20995-2-kgoldman@us.ibm.com>
 <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
 <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
 <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <7f070a41-97a8-2cf7-930f-8d194b5b8a97@linux.ibm.com>
Date:   Thu, 15 Oct 2020 09:04:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_07:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/14/2020 6:28 PM, Mimi Zohar wrote:
 >>>>
 >>>>    fi
 >>>> @@ -73,6 +74,8 @@ swtpm_start() {
 >>>>    			SWTPM_PPID=$!
 >>>>    		fi
 >>>>    	elif [ -n "${swtpm}" ]; then
 >>>> +	        # tpm_server uses the Microsoft simulator encapsulated packet format
 >>>> +                export TPM_SERVER_TYPE="mssim"
 >>> Exporting TPM_SERVER_TYPE like this is causing openssl/tumbleweed to
 >>> fail.
 >>>
 >> That's odd.  Are you saying that openssl uses the env variable
 >> TPM_SERVER_TYPE?  What in openssl fails?  What's the error
 >> message.
 > "make check" is showing:
 >
 >
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 3: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 4: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 5: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 6: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 7: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 8: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > 9: pcrread: failed, rc 00000100
 > TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
 > initialized
 > INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks
 > Failed to read any TPM PCRs
 > errno: No such file or directory (2)
 > SKIP: evmctl ima_boot_aggregate:

Are you sure that this failure is within openssl?  It doesn't look
that way to me.

Were there perhaps more of those errors?  I suspect that because
the messages are labeled 3-9, but PCR 0-9 are read.

I don't know the test code.  My guess is:

- If there were 10 errors, the startup command is missing,
causing each PCR read to fail.

- If there were 9 errors, startup is being sent before each PCR read,
but only one is permitted.



