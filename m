Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8613425C6E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJGTny (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Oct 2021 15:43:54 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:59744
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240908AbhJGTnx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Oct 2021 15:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqidA0OmtpSf1TG4np5lFKwl4NOa7T0LOL1NpzfZ3Y++BpyGzcaIuxDoY0D3gPVVEF/r5cN0Y6iywVBj377vafrzKQGELLZ9hAq0GKkVODvpQ1KlW6Pj9M4l0xWSunPcP5niDrvXsGPzEFLIJexuAqFboJiJ/rHBNyG4J3q6nvGV3rVPRqn9HiHBx9QTQpacgwz2r/Jrk5b9+7CIV0iZL/5kV9iOp2agNqUQSMr8W7Om8rxTQamS6KUn2UqHjE7B/CSZmpom1Ygjw7ykkcFa0LtEbFXJDMiO2Ov0a30Y+/Ape75GvjECqJWDVD/9hjsRv/3L//wcrQM/pecGJgnKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJl3NS0XQJDUmvM9V/PNIaiIz3Z2jt2Y77EUt/f6EsQ=;
 b=mtfnXxip2kHYcoR2fB+qgtr/YL8gulOwJ+zlhW9xpoUYpEqUAJkiG6mt+jN3ftmYdZ5PBSjM50+5D2Z/aytvFY4NeIc6iVdtrI/kMB2xK0P9bIY4MtYZqB+JuxWx3ksM40zWdUVUSJyqIarn7gV0l4orLcdNGHhUkcvLLdtqMWJg3s3vfcKC9G+NFLNQTAmZ1U7UToVz5upWgPNOvt5I5dTX1TfwMwZoGjA4ryfwPFytbqiroe0t+mZD6CfMS9yphri+g8kgdn7MrcAazolU20PrfCO/NB8dZ3LoHQxI+1Ht5G8fzafEYrwwG4JVLfjS1zy9zwC8GZra02MzDA3yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJl3NS0XQJDUmvM9V/PNIaiIz3Z2jt2Y77EUt/f6EsQ=;
 b=hbLMxGEaDa1H1hUiTU41XVMxQQpuMK2obbTJV0Rpt5fUn02gUJXHKCNGtLomPBtj0AgcF5G0bVdYdLIWoFhsolxZ98LjICKDx7r5sBT8vi8D11Bw9wjJQhAzm29r9Obd9HJAjPegT2ud3ca3CRtuLWZ6/s/lWRWweF0YR6yEk1A=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB3517.namprd07.prod.outlook.com (2603:10b6:301:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 19:41:57 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 19:41:56 +0000
Date:   Thu, 7 Oct 2021 13:41:55 -0600
From:   Alex Henrie <alexh@vpitech.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, pvorel@suse.cz,
        alexhenrie24@gmail.com, Curtis Veit <veit@vpieng.com>
Subject: Re: [PATCH v2] ima: add gid support
Message-Id: <20211007134155.33964293864ff7ffa7cae691@vpitech.com>
In-Reply-To: <81863154aebf9d3e023bd37acca8ff265a187fd0.camel@linux.ibm.com>
References: <20211005003237.501882-1-alexh@vpitech.com>
        <81863154aebf9d3e023bd37acca8ff265a187fd0.camel@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter (66.60.105.30) by MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Thu, 7 Oct 2021 19:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e0d5cf-15ee-42e4-69a7-08d989ca856d
X-MS-TrafficTypeDiagnostic: MWHPR07MB3517:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3517ED0F8D14DE5157E11247B8B19@MWHPR07MB3517.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqLYMt9U7Lz1xuQMdUfvM9NGeqfbgdrCtfuAcu9kKuvP301fdWKQvte5dhQ+N73WHOS1yOaPPU61z/guenfCdXQhlVjBbNZwirCUSN13OMYWVTMNCrFbzAn97yMTmn8vlu4dXg1kNuUmQAC+cCtmd6zXA8UFiNp3OFhN58hoUK7l5JuwjTstDYJGdoBpW5Q4AZIfNUXWOrmRyssgpLY4lpQ5p4txvXYiQL75SrY6IxnYHA/Lyi3jhKTQ2tSkbNgvTRvzP6EGvIFs+/zygPqF7eUsoU5z2RnljlbKRPIgnT6PvECpBggEi0E/u3uvIeZHtZyzJ7zXX6xnXgzLNih8G8MJPasA0UgX20d2n3PdyJQvv2JhzH8ekNaZZn8gL5LbsdeIzt/Nch1OUaIMNyf9NEM2QBRUQV64vFZNpEpcAidlmu9tDK6f3Zp1YOyZqo2NWMqij7h04AweLgdfZb9B9TtO4OyAnfncYQ71gEZgPUCkjRMEiKUsug/2ZQTTc3+D0I7psLrAaEe75cEsRZy2DKiXOA0tF58kq6eJZwZLcHDnVOqiY8fyuQiz8m6Sq0HZYEivbmIghIVnif+iWrTqpx/AKXRqfYlgGRnY7rMb15JKT4Zc9mgsY6Ow3GZDinO8/SJHFe2aVTor0uB1/5t8Dint/VZib68PJNV8axjPz8B1bdFWoXcaabUh4ku9rZoQfDn/DiYjmPvUq9OojB9Vg5l6LVTUlakVkLhcLhBPMMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(39840400004)(376002)(186003)(4326008)(5660300002)(66946007)(66476007)(1076003)(26005)(66556008)(38100700002)(8936002)(956004)(6916009)(38350700002)(508600001)(2616005)(2906002)(36756003)(316002)(107886003)(8676002)(6486002)(6496006)(83380400001)(52116002)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+7fM1CRkFY0a6evBy8ow1PSOtprAaWZ/+icx/1n5xYk95cQMarBS2Ddrxgd?=
 =?us-ascii?Q?bhEqq6b5N5mG2eHEiEF8egccgtZHqJpgDWzfcoLx0lGmMMDU20Rem02cbNyQ?=
 =?us-ascii?Q?p9glCNDRuiuoBArVWd8ECU028W3hUrXc8dMn/uU1V0k7Yhe3QDrAMR+7bVXE?=
 =?us-ascii?Q?8BrCqxqIXuXBUUAi2sjlYAi80rZZThgdOKxoqOnZeFTA9MohWUuDtPq2/bAZ?=
 =?us-ascii?Q?N6EDNHBpPGfMUIYUdm3dhw1cDiaX3i/dLQVbFsxDY+cD6cWgbvD3vZ6zwrfm?=
 =?us-ascii?Q?ixFyI3uRfs4TicgL3XQlgtLQ1evliiy63yZ8/fcGdSd1RLn3B0pWtTXQblSH?=
 =?us-ascii?Q?peKpTg6RukYGKIOGEMHRMTD0uGuOH1cdXjwpBaO0jSQF+nWxMibk/zy2kjJi?=
 =?us-ascii?Q?oBzwvPCNrhW1C5Rf6u15nLIbAdqWFiL7GR4jUrd7aWYJo/THCFiNFlYZN8Bc?=
 =?us-ascii?Q?ZTcTdK5TZIsYqZDHvcWTPWJ6SYfQB905zTI/OPMAam0Z8S/8HdB8U/ynTKCU?=
 =?us-ascii?Q?QlkuwNqfEoYS2W6g3Mwf8/6lUBHzSgongpUuL4Qh7cNhB/kO5ZUn1pC9tpK3?=
 =?us-ascii?Q?QFBZupVf4o5u8EeQgBfTjkVxn3Xj0PoOOXAptPnY30x9by7LIycI7q/ubQdY?=
 =?us-ascii?Q?ne+GGHIoQGZZvNtO5HMYOAzgjkWJiBUIJHB2F+p1hIV+RrYEemGXv7dFDnyn?=
 =?us-ascii?Q?7yk/Wrc0Ubj9S25F4uPAsjX5BUptd7aWD+I0zht1F96W3q0rw1+uyO4ctDdH?=
 =?us-ascii?Q?gtOKr0vmxH3xMJ0rf2DS5Qmz/3RVfAlzo618A4PlRIYI1h8RboT/A06GIV7e?=
 =?us-ascii?Q?sZec7PuvwKoVW1lJloBzt+AGltk5GHPtxmvgnCv4UQITIAd9cOia6srJmAnI?=
 =?us-ascii?Q?saCDDZCndXJ3D3uKQEk9IIXNxW/U2uOVt1I20eVNqmDhWetkyZSQ5/Ip1LRc?=
 =?us-ascii?Q?VWrcrqUYCpwqQdH12gRbNkmNO6SqZHxnR96fnb4uVD12AioS9aVcXvya4VBF?=
 =?us-ascii?Q?0mp2xWp167bgF7LkhLlzcDceshh2nTDpTco5e/rmXZhTI4L2ThimbaL4C8Mz?=
 =?us-ascii?Q?VduJmg6Ey+bzdXVSef8LFUK4dBWie3BHhCelvGH54CwRIHoI/CZOVPbrpVET?=
 =?us-ascii?Q?oeRtE1qLhkOmeKwXBGmgEzvYcbPhYkKM5oLMeXh4NwOBRa/3kwthgFJaB//H?=
 =?us-ascii?Q?Tx+hKxehC11/7LYFxFHM8WbdE0ueYB4um/v9UebD37KqPsrv/dgccrt83mL5?=
 =?us-ascii?Q?BNIHXAq2Vu9P6lg44SbfZHvyQFAgTlPWVjN5YJjbWymY60dFYX/yRn7zm5KH?=
 =?us-ascii?Q?J/NosHZAt/iQd0K+cbHcanBF?=
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e0d5cf-15ee-42e4-69a7-08d989ca856d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 19:41:56.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvGvXFcjqwQNzCPmDZp80qtr+LILdo0j0Ov0/fl6kQalHbspZppiVwsRGrBX+IObT9hMYS6kwNNkX0+ayFtQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3517
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 06 Oct 2021 15:49:58 -0400
Mimi Zohar <zohar@linux.ibm.com> wrote:

> On Mon, 2021-10-04 at 18:32 -0600, Alex Henrie wrote:
> > @@ -78,9 +81,13 @@ struct ima_rule_entry {
> >  	unsigned long fsmagic;
> >  	uuid_t fsuuid;
> >  	kuid_t uid;
> > +	kgid_t gid;
> >  	kuid_t fowner;
> > +	kgid_t fgroup;
> >  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
> > +	bool (*gid_op)(kgid_t, kgid_t);
> >  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
> > +	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */
> 
> scripts/checkpatch.pl complains about missing variables.

I'll resend with a new patch that fixes the existing style problems
with the UID code before adding GID support.

> > @@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
> >  		} else if (!rule->uid_op(cred->euid, rule->uid))
> >  			return false;
> >  	}
> > -
> > +	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))
> 
> All of uid_op/gid_op calls in ima_match_rules() pass the "cred->xxxx,
> rule->xxx" except here, where it is rule->gid, cred->rule.   Reversing
> the parameters here will help with addressing the checkpatch.pl
> warning.

Good catch, thanks.

-Alex
