Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100203B89DD
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhF3Uub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 16:50:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5178 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229700AbhF3Uub (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 16:50:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UKWwrd069684;
        Wed, 30 Jun 2021 16:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=awNCcezo7oqKmu/xNMtkiiVSjLwJ01yiX6D0pOQ4AsA=;
 b=Zut7wefnoDpbGQMLEFQbxdBvS97gQs6PZfHyVEXmNkFmU1DmAeOeF7lVhFO1suxNOfjX
 LUDsCam4+tg/puZzMK4OgXt2F5WziqbwZZWniNEmKS9WoqQayJiaM7zJRX2TAVsoJdaS
 PGuQcTz6NIBMXDo7+9f/jOXm9TcABPjgCHo4ZppZWMxjljbN5VhuUiulqSht+OMWpDtT
 /OVZw4cbCGcjPmSUEv+4Uu1idHd7NJSPOaqB+4IVrb7XaTpyJREd8MjjEX2rtJYZ1zmM
 SCOM2OuHmgqlfiUvJp5vqXL3SY/jSaFyOzLR9OUv8r3sFY2yEgjjeDeTeYl3pIQcIWqU bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gwhum54f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 16:48:00 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15UKgVeW113639;
        Wed, 30 Jun 2021 16:47:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gwhum53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 16:47:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UKhQ7U031593;
        Wed, 30 Jun 2021 20:47:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 39duv89ynd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 20:47:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UKltPH14811470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 20:47:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B00214C040;
        Wed, 30 Jun 2021 20:47:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903124C044;
        Wed, 30 Jun 2021 20:47:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.114.126])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 20:47:54 +0000 (GMT)
Message-ID: <3aa852febc49d159783597b0de56060cf5efb269.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Wed, 30 Jun 2021 16:47:53 -0400
In-Reply-To: <20210630194451.laico5ziqy3fw4eh@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-2-vt@altlinux.org>
         <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
         <20210626004241.wkkjsbbesakszfkj@altlinux.org>
         <f2355538832153c82c866d1e779b128a9612b6cc.camel@linux.ibm.com>
         <20210629013201.xelhje2hmiuqybrt@altlinux.org>
         <2f494e1d5c2c99a4b7c0912faa4c3be3de682afc.camel@linux.ibm.com>
         <20210630194451.laico5ziqy3fw4eh@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y9q_Z_oqqG9WMICmtcjyksmzEnSeGNMD
X-Proofpoint-GUID: hvM7gAuk8VZ2c7K80tT4pC64buFMvKE4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_11:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Wed, 2021-06-30 at 22:44 +0300, Vitaly Chikunov wrote:
> On Wed, Jun 30, 2021 at 12:39:02PM -0400, Mimi Zohar wrote:
> > On Tue, 2021-06-29 at 04:32 +0300, Vitaly Chikunov wrote:
> > > On Mon, Jun 28, 2021 at 04:50:42PM -0400, Mimi Zohar wrote:
> > > > 
> > > > Thank you for the detailed explanation.
> > > > 
> > > > On Sat, 2021-06-26 at 03:42 +0300, Vitaly Chikunov wrote:
> > > > 
> > > > > > Requiring the optarg value to be prefixed with "0x" would
> > > > > > simplify the strlen test.
> > > > > > (The subsequent patch wouldn't need a contrived prefix.)
> > > > > 
> > > > > (I do not understand this remark at the moment.)
> > > > > 
> > > > > Base 16 will let user pass keyid just as a string, copy-pasting from
> > > > > somewhere else.
> > > > 
> > > > strtoul() supports prefixing the ascii-hex string with "0x".  To
> > > > differentiate between a keyid and pathname, why not require the keyid
> > > > be prefixed with "0x", as opposed to requiring the pathname to be
> > > > prefixed with '@', like "--keyid @/path/to/cert.pem".
> > > 
> > > I wanted to avoid (filename vs keyid) ambiguity of the argument to
> > > `--keyid' - if user have file named "0x00112233" they would have hard
> > > time passing it to `--keyid'. But, it's impossible to have keyid string
> > > starting with "@". So, "@" perfectly distinguish type of `--keyid'
> > > argument but "0x" isn't.
> > > 
> > > Also, in some software (zip, rar) "@" is common prefix meaning value
> > > should be taken from the specified file. But, yes, "@" is not common
> > > in Unix environments. Do you want me to create separate option like
> > > `--keyid-from-file'?
> > 
> > It's highly unlikely that both the filename and pathname would be
> > prefixed with "0x".  Defining a new option might be a good idea. 
> > Possibly naming it --extract-cert-keyid,  ---cert-keyid, or --keyid-
> > from-cert.  
> 
> It's not unlikely, because people may want to keep cert files named or
> symlinked by keyid. (For example, local cert database keep cert files
> symlinked like `f30dd6ad.0'.)
> 
> I will add an option, most understandable, perhaps, is `--keyid-from-cert'.
> 
> Also, I will remove base 16 from --keyid argument.

I must be missing something.  "openssl x509", "keyctl show
%keyring:<keyring name>", and "getfattr -m security.ima -e hex --dump"  
all display the skid in hex.  Why would anyone provide the skid as
something other than in hex?

thanks,

Mimi 


