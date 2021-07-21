Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB093D18DC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGUUgl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 16:36:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhGUUgl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 16:36:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LL5mqt087405;
        Wed, 21 Jul 2021 17:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PPqpYqJ1JDguWq/vNh5fou/Ac31HWcbwEtSd8wu2/0c=;
 b=k/alX9CeBVc0MX/AO8kJ6YGfWgIRH14urs3IzzCzVVsgaleRM79gYqkwtsCaFjcrNo1x
 ItXa9J2LVrT26fEjiXXwP5tYbXSYQw3ksxWhNpAzeUm3D3GE5h0atOOI+J7L/QzOflf5
 ox/M6OmeziLEH0fWK/SL8wmGi1xL9FG/P+YFpQw2dRjIAUiQnPYo82SNMuPHfAXcB6u3
 Eogub2v1kyJQwJ4z9v94Zf7f8p9Y8mRhQbojwnSWPXgCODPFtyEcEsxXBhdGxQtogae8
 Z6d+ly4jdkFL7bCLcz4LeFR78JahHJPgxjD5/0mX+9p9gGHquVI3DiECucjVFmrZiayE 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xs903bah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 17:17:16 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16LL5mQM087418;
        Wed, 21 Jul 2021 17:17:16 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xs903b9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 17:17:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LLHECm026737;
        Wed, 21 Jul 2021 21:17:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng71qrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 21:17:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LLElB925624832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 21:14:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA104203F;
        Wed, 21 Jul 2021 21:17:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 648EF42041;
        Wed, 21 Jul 2021 21:17:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.57.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 21:17:10 +0000 (GMT)
Message-ID: <758a4a85e0fb92e8cbc62b218c12b02f9123f640.camel@linux.ibm.com>
Subject: Re: [PATCH 1/7] dm: measure data on table load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com,
        linux-integrity@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Wed, 21 Jul 2021 17:17:09 -0400
In-Reply-To: <a6887d022d3943e0ca1efb845270fa715a60b925.camel@linux.ibm.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
         <20210713004904.8808-2-tusharsu@linux.microsoft.com>
         <713d22788b678c612c5b18edfb8cf849af61ace5.camel@linux.ibm.com>
         <YPhAaAyo8fKXzu5c@redhat.com>
         <a6887d022d3943e0ca1efb845270fa715a60b925.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6M6BjysTFcr79kMlW3sc5b0coo1wpMnO
X-Proofpoint-ORIG-GUID: w0pjyFOM_vawjBFMbwy4XCSp4Zoynf5y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_10:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-21 at 12:07 -0400, Mimi Zohar wrote:
> On Wed, 2021-07-21 at 11:42 -0400, Mike Snitzer wrote:
> > On Tue, Jul 20 2021 at 10:12P -0400,
> > Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > > Hi Tushar, Mike, 
> > > 
> > > On Mon, 2021-07-12 at 17:48 -0700, Tushar Sugandhi wrote:
> > > > +struct dm_ima_device_table_metadata {
> > > > +       /*
> > > > +        * Contains data specific to the device which is common across
> > > > +        * all the targets in the table.e.g. name, uuid, major, minor etc.
> > > > +        * The values are stored in comma separated list of key1=val1,key2=val2; pairs
> > > > +        * delimited by a semicolon at the end of the list.
> > > > +        */
> > > > +       char *device_metadata;
> > > > +       unsigned int device_metadata_len;
> > > > +       unsigned int num_targets;
> > > > +
> > > > +       /*
> > > > +        * Contains the sha256 hashs of the IMA measurements of the
> > > > +        * target attributes key-value pairs from the active/inactive tables.
> > > > +        */
> > > 
> > > From past experience hard coding the hash algorithm is really not a
> > > good idea.
> > > 
> > > Mimi
> > > 
> > > > +       char *hash;
> > > > +       unsigned int hash_len;
> > > > +
> > > > +};
> > 
> > Hi Mimi,
> > 
> > The dm-ima.c code is using SHASH_DESC_ON_STACK and then storing the
> > more opaque result via 'hash' and 'hash_len'.
> > 
> > So if/when the dm-ima.c hash algorithm were to change this detail
> > won't change the dm_ima_device_table_metadata structure at all right?
> > But even if changes were needed this is purely an implementation
> > detail correct?  Why might users care which algorithm is used by
> > dm-ima to generate the hashes?
> > 
> > Assuming there is a valid reason for users to care about this, we can
> > improve this aspect as follow-on work.. so I don't consider this a
> > blocker for this patchset at this point.  Please clarify if you feel
> > it should be a blocker.
> 
> This goes back to my question as to if or how the template data in
> these DM critical data records are to be validated by the attestation
> server.   Asumming the hash/hash_len is being stored in the IMA
> measurement list, the less the attestation should need to know about
> the specific kernel version the better.

Hi Mike, Tushar,  Laskshmi,

Perhaps, when defining a new IMA "critical data" record, especially if
you know it's going to change, the critical data should contain a
version number.

thanks,

Mimi

