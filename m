Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AB24A218
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHSOxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 10:53:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgHSOxv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 10:53:51 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEWtXN128495;
        Wed, 19 Aug 2020 10:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zd2fT0Anejr+c8D5mKy6gFA34vHrw9bWsc2P5OzRX2A=;
 b=hbB8esOCa1n23BjpiYKY9vZwucPdT9tSd1xjLx1aYfRGuoWkVn+yJkYji4AusFyEdxMt
 wODf8g8QvYQHwaeMzfi33GuDR2Wzwu4dR56ArhGdk7tSrqtkk6cvQbf6x8TyFKSvct+y
 iPwKrP9KAAFeiIjBivihPDRoXYHgZybzVVuR2erkDJIMWSwYpVhLcogcOIciqrZj8w5N
 736tzL4CjJ9O8ffHohjK4ZEgcTYBtVqlQUEcjh1/RrHzj5ZWhl1OZH59ubDLWZgre+0E
 5chGtNY9QdAbSr+Mw1cQQqRub6/fXv2BKoQ0fGBCLDbaAfWeUEUSGcCmiLaSnvCCbnUe 1g== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 330ccb60kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 10:53:45 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07JEp4fM019134;
        Wed, 19 Aug 2020 14:53:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3304buh7qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:53:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07JErett30146976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 14:53:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74F59AE055;
        Wed, 19 Aug 2020 14:53:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B1E0AE056;
        Wed, 19 Aug 2020 14:53:39 +0000 (GMT)
Received: from sig-9-65-250-194.ibm.com (unknown [9.65.250.194])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Aug 2020 14:53:39 +0000 (GMT)
Message-ID: <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 10:53:38 -0400
In-Reply-To: <20200819140943.GH1152540@nvidia.com>
References: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
         <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
         <20200819140943.GH1152540@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=3 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 11:09 -0300, Jason Gunthorpe wrote:
> On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
> > On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> > > 
> > > > The problem is that there isn't just one single userspace library or
> > > > application for reading PCRs.  So now not only is there the kernel
> > > > "boot_aggregate" regression testing, but regression testing of the tool
> > > > itself to support multiple methods of reading the PCRs.
> > > 
> > > I was thinking just open code 
> > >   open("/dev/tpm")
> > >   write(read_pcrs_cmd)
> > >   read(read_pcrs_cmd)
> > >  
> > > It isn't particularly hard to retrive the PCRs, don't really need to
> > > depend on a library.
> > 
> > Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
> > do you also have code to parse the TPM 2.0 event log that you could
> > contribute?
> > 
> > Seriously, we shouldn't be (re-)writing code to do this.
> 
> The kernel should not be used a dumping ground to work around a
> dysfunctional userspace either. :(
> 
> You've basicaly said you can't rely on a sane userspace library
> because *reasons* so we need to dump stuff in the kernel instead.
> 
> It is not a good justification to add new uAPI.
> 
> James seems to have the same basic conclusion too, unfortunately.

"dysfunctional" is dropping existing TPM 1.2 sysfs support, which was
done without consideration about existing applications/tools (e.g. ima-
evm-utils, ltp) and without community input.  It's not only James that
is advocating for exporting the TPM PCRs, but Jerry Snitselaar, who
reviewed this patch and exported the TPM version, and Nayna Jain, who
exported the TPM 2.0 event log.  I'm pretty sure there are a number of
other people who would agree.

Mimi

