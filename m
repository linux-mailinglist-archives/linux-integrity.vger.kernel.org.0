Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3C36FBA8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhD3Nph (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 09:45:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30464 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhD3Nph (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 09:45:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13UDY4p7009901;
        Fri, 30 Apr 2021 09:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3Wz/FDxKAE+G6huCXdXnm+EkW0Fr8Z6s0tKwKjECrrI=;
 b=KZ/hIt9Fj8EJUh4o4G0KjiZAdzr01KGB580eAoofLPXn6NbrqY8L4my1vM4LEb/awBtf
 m+dHKLz7dD+/dT+GG5vjvZsqoRnUBIO1zYhnCC6t5eGPP3AKQFAig0xT7qCP5lPJJ3QF
 1mwerdodjukN60S4+QBTwIzvyr7uRj7HkjdEtO2QDVkfrWSD5SJnTESSYr90Xex3l/T8
 ae2iDmDA/lGG12XgLVa0QvxiuX5Vfsjce+KAEonkWjhd29oP7S0Hg2AglLSGC1caAW0j
 D44VQYzZKphSZ9f63N8QIUuTctYmi7b0AbpT3as2kq8KemBWAPxz0mob6OSCDnl5soJ/ hQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388jp88qeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 09:44:46 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13UDi9Xq000868;
        Fri, 30 Apr 2021 13:44:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 384ay81rg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 13:44:45 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13UDig1O29819314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 13:44:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF19152051;
        Fri, 30 Apr 2021 13:44:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.32.5])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 72A1252054;
        Fri, 30 Apr 2021 13:44:41 +0000 (GMT)
Message-ID: <a3db607d43565699e3d08c941161d1cfa69f28ac.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] travis: Fix Fedora
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@us.ibm.com>
Date:   Fri, 30 Apr 2021 09:44:40 -0400
In-Reply-To: <YIwFFwf80Hj178zK@pevik>
References: <20210429053918.10240-1-pvorel@suse.cz>
         <07d6895b02ea3818b0687d79f66575fc08ff6c97.camel@linux.ibm.com>
         <YIwFFwf80Hj178zK@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N7cr_xr0LUrG3IzuLcZ_jz2cAzgGAVpZ
X-Proofpoint-ORIG-GUID: N7cr_xr0LUrG3IzuLcZ_jz2cAzgGAVpZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_06:2021-04-30,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300095
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Stefan]

Hi Petr,

On Fri, 2021-04-30 at 15:24 +0200, Petr Vorel wrote:
> > On Thu, 2021-04-29 at 07:39 +0200, Petr Vorel wrote:
> > > Fedora recently got 2.33, which requires on Travis CI to use podman.
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi Mimi,
> 
> > > Tested [1].
> 
> > > Previously Fedora fails on autoconf issue [2], which is caused by
> > > faccessat2 incompatibility on glibc 2.33:
> 
> > > /usr/bin/autoconf: This script requires a shell more modern than all
> > > /usr/bin/autoconf: the shells that I found on your system.
> > > /usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
> > > /usr/bin/autoconf: including any error possibly output before this
> > > /usr/bin/autoconf: message. Then install a modern shell, or manually run
> > > /usr/bin/autoconf: the script under such a shell if you do have one.
> > > autoreconf: /usr/bin/autoconf failed with exit status: 1
> 
> > > [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/768789641
> > > [2] https://travis-ci.org/github/pevik/ima-evm-utils/jobs/767259578
> 
> > The "boot_aggregate" test should succeed, but for some reason is now
> > being skipped.
> 
> > PASS: ima_hash.test
> > PASS: sign_verify.test
> > SKIP: boot_aggregate.test
> Not sure why, I'll try to have look. Maybe missing dependencies?
> I suppose this is not related to the patch at all.

The boot_aggregate test has a dependency on a software TPM.  From the
end of the log, there's problems communicating with the swtpm.

which: no tpm_server in (../src:/root/ima-evm-utils-install/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
INFO: Starting software TPM: /usr/bin/swtpm
INFO: Sending software TPM startup
TSS_Socket_Open: Error on connect to localhost:2321
TSS_Socket_Open: client connect: error 111 Connection refused
startup: failed, rc 000b0008
TSS_RC_NO_CONNECTION - Failure connecting to lower layer
INFO: Retry sending software TPM startup
TSS_Socket_Open: Error on connect to localhost:2321
TSS_Socket_Open: client connect: error 111 Connection refused
startup: failed, rc 000b0008
TSS_RC_NO_CONNECTION - Failure connecting to lower layer
INFO: Software TPM startup failed

> 
> > I tested with/without this patch on our internal travis.   I was seeing
> > the Tumbleweed problem, but am not seeing this problem with Fedora
> > latest yet.  Both with/without the patch, Fedora latest works properly
> "not yet" => if you check glibc package update for the version. I bet it's still
> 2.32. Thanks for testing it.

From the local raw log:
  glibc-devel-2.33-
5.fc34.x86_64                                                
  glibc-headers-x86-2.33-5.fc34.noarch

thanks,

Mimi

> > on our internal travis.

