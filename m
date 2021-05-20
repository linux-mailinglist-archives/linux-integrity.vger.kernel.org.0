Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1138B87B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhETUgk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 16:36:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235604AbhETUgj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 16:36:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KKYGbl091553;
        Thu, 20 May 2021 16:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aZZftVZ/pAP26oHjR5pXar7PvCEzNF35bn5jDcE4TDI=;
 b=gLbt2BU40nT9mokmROMLup5NRcekF2YrcWfQCbMOt19UtGiCqKwwxs4Jp9tq23qs7rUt
 w0Kw4FeJ16HLt+H/ZyXgUcDk/SWo/bUZdXBOL6t3INSEEo3QsebIL7JHC1DAujIH72T0
 Q3KWYy7qi47Yf2a5bY+Lnc/QoNV8f7OHgZ3UesCASjDYLGsIRR5g6ZMBd/lVzyxaNUfQ
 egyJ/UxrxjKpxC2uHMHRl/8BX8aLqF6psXORUFwNWvFh2FTaNNYfMknrgv7Hu3RBldqa
 TYK/lHRcK4jsm8KPd3aCLe/GTaUh0Aapl2h5RdSWmqwCCSve+2UaOwfAtgDJG+mGEuBC pg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nwrqsvpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 16:35:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KKWWZY005507;
        Thu, 20 May 2021 20:35:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 38m19sry2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 20:35:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14KKYdFn28836104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 20:34:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71325A4053;
        Thu, 20 May 2021 20:35:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D78CA4059;
        Thu, 20 May 2021 20:35:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.39.138])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 20:35:05 +0000 (GMT)
Message-ID: <4b21151fc53855049c8a452339be88be2e26f53c.camel@linux.ibm.com>
Subject: Re: [PATCH v4] IMA: support for duplicate measurement records
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, pvorel@suse.cz
Date:   Thu, 20 May 2021 16:35:04 -0400
In-Reply-To: <20210510190939.28279-1-tusharsu@linux.microsoft.com>
References: <20210510190939.28279-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 48umb1cKbqRMQaAlCEfOnprriuxiiStD
X-Proofpoint-ORIG-GUID: 48umb1cKbqRMQaAlCEfOnprriuxiiStD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_06:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105200128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Mon, 2021-05-10 at 12:09 -0700, Tushar Sugandhi wrote:
> IMA measures contents of a given file/buffer/critical-data record,
> and properly re-measures it on change.  However, IMA does not measure
> the duplicate value for a given record, since TPM extend is a very
> expensive operation.  For example, if the record changes from value
> 'v#1' to 'v#2', and then back to 'v#1', IMA will not measure and log
> the last change to 'v#1', since the hash of 'v#1' for that record is
> already present in the IMA htable.  This limits the ability of an
> external attestation service to accurately determine the current state
> of the system.  The service would incorrectly conclude that the latest
> value of the given record on the system is 'v#2', and act accordingly.
> 
> Define and use a new Kconfig option IMA_DISABLE_HTABLE to permit
> duplicate records in the IMA measurement list.
> 
> In addition to the duplicate measurement records described above,
> other duplicate file measurement records may be included in the log,
> when CONFIG_IMA_DISABLE_HTABLE=y.
> For example,
>     - i_version is not enabled,
>     - i_generation changed,
>     - an inode is evicted from dcache etc.

Missing from this list are the same file, perhaps on different
filesystmes, such as initramfs and real root.  These can be identified
by the different i_ino.  Is there anything else?

thanks,

Mimi

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

