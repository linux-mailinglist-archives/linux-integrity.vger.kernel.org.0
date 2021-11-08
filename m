Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD8449EA4
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Nov 2021 23:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhKHW1F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Nov 2021 17:27:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229627AbhKHW1F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Nov 2021 17:27:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8MNYVV013965;
        Mon, 8 Nov 2021 22:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ObuCR1oYdSOvW6kwLjS49gGfTVpg8zrPjP0cS4tjOxI=;
 b=Ovaul1ayQNQdE5MFNsNxpJfVIWq8JX6zAD7N13zTRbzUF3is6OnbmZrHxUB0tRxEZkR4
 uKYvyW32+Glac9qDLxeakTgKmdC+JhXyCsSpHKlBZz5KjnSXrKKoOTmALtXwtiqhLWKe
 LAxKKcKq6m7MDoitDrVDnchRI/YiGTMw2BZQESKxta+2KVlY0f8tHkFt+kpjc9JUWyEU
 m+Xuw3egjj60NOqdNQzPsUqb/9NqLt3YVSdvUypogO/P+nF2FtLsKKl9OT0I/afLwh8N
 Lsa2p66iTHK2n1b0uHm6ttuckApP9eT5Z6pOzqcmkYC0Zs/nenGNMHRak9MVjvwPx2LS PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7cn6r08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 22:24:15 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8MOEVX016655;
        Mon, 8 Nov 2021 22:24:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c7cn6r080-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 22:24:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8MMMuY023116;
        Mon, 8 Nov 2021 22:24:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3c5gyjrub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 22:24:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8MHVip65012100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 22:17:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A1B4C059;
        Mon,  8 Nov 2021 22:24:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01B754C046;
        Mon,  8 Nov 2021 22:24:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.5.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Nov 2021 22:24:07 +0000 (GMT)
Message-ID: <e247769212d137e9d1584e30c42a5bebeb3c11c9.camel@linux.ibm.com>
Subject: Re: ima-evm-utils: version 1.4 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Ken Goldman <kgold@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Mon, 08 Nov 2021 17:24:07 -0500
In-Reply-To: <e7bdd3d2-8928-b3d4-852e-83ff3e988bc0@linux.microsoft.com>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
         <YYToG+8u/edIcc3u@pevik>
         <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
         <36ee20b3-cdd7-e879-7c8b-235578e41628@linux.ibm.com>
         <e7bdd3d2-8928-b3d4-852e-83ff3e988bc0@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NOL5iOGbJpQeDE09BW61zBQH_Iiaj4e6
X-Proofpoint-GUID: HKPWBLdbDGjldF2VakC1_VOKfFlhqMH9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-11-08 at 12:46 -0800, Lakshmi Ramasubramanian wrote:
> Thanks for the response Ken.
> 
> >> I am seeing the following errors when trying to validate IMA 
> >> measurement using the util. I'd like to try the latest (v1.4).
> >>
> >> sudo ./evmctl ima_measurement
> >> /sys/kernel/security/ima/binary_runtime_measurements  -vv
> >>
> >> Error messages for the above command
> >> ------------------------------------
> >> Using tsspcrread to read PCRs.
> >>
> >> tpm2_pcr_supported:67 Found 'tsspcrread' in $PATHread_tpm_banks:1923
> >> Failed to read sha1 PCRs: (TSS_Socket_Open: Error on connect to
> >> localhost:2321)
> >>
> >> read_tpm_banks:1923 Failed to read sha256 PCRs: (TSS_Socket_Open: Error
> >> on connect to localhost:2321)
> >>
> >> Failed to read any TPM PCRs
> >>
> > 
> > This sounds like your program is trying to connect to a SW TPM,
> > and the SW TPM process is not running.
> > 
> 
> There is a physical TPM on the machine where I am running ima-evm-utils 
> to verify IMA measurements. I want to use that physical TPM and not a 
> software TPM.
> 
> I am seeing the error with v1.4 sources as well.
> 
> I will review ima-evm-utils code and check how to get it to use the 
> physical TPM for validating the IMA measurements.

This release has support for linking with "-libmtss", in addition to
calling the command line tools.  Check the configure output to see
which TSS you're using.

If you're using the IBM TSS, first make sure that "tsspcrread -halg
sha256 -ha 10 -ns", for example, is actually working.

thanks,

Mimi

